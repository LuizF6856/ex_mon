defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message do
    IO.puts("=== the game is started! ===")
    IO.inspect(Game.info())
    IO.puts(create_line(25))
  end

  def print_wrong_move_message(move) do
    IO.puts("\n==== Invalid Move: #{move} ====\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n==== The Player attacked the Computer dealing #{damage} damage. ====\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n==== The Computer attacked the Player dealing #{damage} damage. ====\n")
  end

  defp create_line(range), do: String.duplicate("-", range)
end
