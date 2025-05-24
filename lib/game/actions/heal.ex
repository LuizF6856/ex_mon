defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game

  @move_heal 18..25

  def heal_yourself(player) do
    Game.fetch_player(player)
    |> Map.get(:life)
    |> calculate_heal()
    |> calculate_total_life()
    |> update_player_life(player)
  end

  defp calculate_heal(life), do: life + Enum.random(@move_heal)

  defp calculate_total_life(life) when life > 100, do: 100
  defp calculate_total_life(life), do: life

  defp update_player_life(life, player) do
    Game.fetch_player(player)
    |> Map.put(:life, life)
    |> update_game(player)
  end

  defp update_game(player_healed, player) do
    Game.info()
    |> Map.put(player, player_healed)
    |> Game.update()
  end
end
