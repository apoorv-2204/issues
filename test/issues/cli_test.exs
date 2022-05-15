defmodule Issues.CLITest do
  use ExUnit.Case, async: true
  doctest Issues.CLI

  import Issues.CLI, only: [parse_args: 1]

  test "parse_args/1 :help return by option parser with options -h --help" do
    # list of argv delimited by space
    assert parse_args(["-h", "anythingelse"]) == :help
    assert parse_args(["--help", "sasageyo"]) == :help
  end

  test "three values returned if three values given" do
    assert parse_args(["eren", "jaeger", 5]) == {"eren", "jaeger", 5}
    refute parse_args(["eren", "jaeger", "5"]) == {"eren", "jaeger", 5}
  end

  test "three values returned if two values given " do
    assert parse_args(["armin", "atlet", "dot pyxis"]) == :help
    # if key value paur then only it consider as that keyword list
    # argument was given
    assert parse_args(["hangi", "levi"]) == {"hangi", "levi", 10}
  end
end
