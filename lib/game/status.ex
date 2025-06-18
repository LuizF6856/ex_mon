defmodule ExMon.Game.Status do
  @moduledoc false

  def print_round_message(%{status: :started} = info) do
    started_message = "=== the game is started! ==="
    size_to_make_line = String.length(started_message)

    IO.puts("\n#{started_message}\n")
    IO.inspect(info)
    IO.puts("\n#{create_line(size_to_make_line)}\n")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    continue_message = "=== it's #{player} turn ==="
    size_to_make_line = String.length(continue_message)

    IO.puts("\n#{continue_message}\n")
    IO.inspect(info)
    IO.puts("\n#{create_line(size_to_make_line)}\n")
  end

  def print_round_message(%{status: :game_over}) do
    continue_message = "=== The Game is Over ==="
    size_to_make_line = String.length(continue_message)

    IO.puts("\n#{continue_message}\n")
    IO.puts("\n#{create_line(size_to_make_line)}\n")
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

  def print_move_message(player, :heal, life_healed) do
    IO.puts("\n==== The #{player} is healing #{life_healed} points. ====\n")
  end

  defp create_line(range), do: String.duplicate("-", range)
end
