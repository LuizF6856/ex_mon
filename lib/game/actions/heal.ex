defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game

  @move_heal 18..25

  def heal_yourself(player, move) do
    heal = calculate_heal(move)

    Game.fetch_player(player)
    |> Map.get(:life)
    |> calculate_total_life(heal)
    |> update_player_life(player)
  end

  defp calculate_heal(:move_heal), do: Enum.random(@move_heal)

  defp calculate_total_life(life, heal) when life + heal > 100, do: 100
  defp calculate_total_life(life, heal), do: life + heal

  defp update_player_life(life, player) do
    Game.fetch_player(player)
    |> Map.put(:life, life)
    |> update_game(player)
  end

  defp update_game(healed, player) do
    Game.info()
    |> Map.put(player, healed)
    |> Game.update()
  end
end
