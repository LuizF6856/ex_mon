defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message do
    IO.puts("=== the game is started! ===")
    IO.inspect(Game.info())
    IO.puts(create_line(25))
  end

  def create_line(0), do: ""
  def create_line(range), do: "-" <> create_line(range - 1)
end
