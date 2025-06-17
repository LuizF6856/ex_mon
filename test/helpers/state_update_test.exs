defmodule ExMon.Helpers.StateUpdateTest do
  alias ExMon.{Game, Player}

  def update_player_life(player, life) do
    Game.info()
    |> Map.put(player, %Player{life: life})
    |> Map.put(:turn, player)
    |> Game.update()
  end
end
