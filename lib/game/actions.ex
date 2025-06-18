defmodule ExMon.Game.Actions do
  @moduledoc false

  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  def heal do
    case Game.turn() do
      :player -> Heal.heal_yourself(:player)
      :computer -> Heal.heal_yourself(:computer)
    end
  end

  def fetch_move(move) do
    Game.turn()
    |> Game.fetch_player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end
end
