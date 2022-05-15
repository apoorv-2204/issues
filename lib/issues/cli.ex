defmodule Issues.CLI do
  @moduledoc """
  Handling the command line parsing and dispatch to
  the various functions that end up generating a
  table of the last _N_  issues in a github project
  """
  @default_count 10

  def run(argv) do
    argv
    |> parse_args()
    |> process()
  end

  def process(:help) do
    IO.puts("""
    Usage: <username> <project> <count>default: #{@default_count}
    """)

    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch_issues(user, project, count)
  end

  @doc """
  argv can be [-h or --help, which returns :help]
  And {github username, project, size(optionall default to 10) }
  Return a tuple of `{username, project, size}`, or `:help`
  if help was given

  two red flags
  conditonal logic
  and too long
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> args_to_internal_representation()
  end

  def args_to_internal_representation({[help: true], [], []}) do
    :help
  end

  def args_to_internal_representation({_, [user, project, count], _}) do
    {user, project, String.to_integer(count)}
  end

  def args_to_internal_representation({_, [user, project], _}) do
    {user, project, @default_count}
  end

  def args_to_internal_representation(_) do
    :help
  end
end
