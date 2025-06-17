defmodule ExMon.PlayerTest do
  use ExUnit.Case

  alias ExMon.Player

  test "build a new player" do
    player = Player.build_player("felipe", "chute", "soco", "cura")

    assert 100 == player.life
    assert "felipe" == player.name
    assert "chute" == player.moves.move_rnd
    assert "soco" == player.moves.move_avg
    assert "cura" == player.moves.move_heal
  end
end
