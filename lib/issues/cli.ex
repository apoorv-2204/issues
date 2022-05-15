defmodule Issues.CLI do
  @moduledoc """
  Handling the command line parsing and dispatch to
  the various functions that end up generating a
  table of the last _N_  issues in a github project
  """
  @default_count 10

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  argv can be [-h or --help, which returns :help]
  And {github username, project, size(optionall default to 10) }
  Return a tuple of `{username, project, size}`, or `:help`
  if help was given
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], [], []} ->
        :help

      {_, [username, project, size], _} ->
        {username, project, String.to_integer(size)}

      {_, [username, project], _} ->
        {username, project, @default_count}

      _ ->
        :help
    end
  end
end
