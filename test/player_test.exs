defmodule PlayerTest do
  use ExUnit.Case

  alias ExMon.Player

  test "build a new player" do
    assert Player.build_player("felipe", "moderate_attack", "variate_attack", "heal") == %Player{
             life: 100,
             name: "felipe",
             move_avg: "variate_attack",
             move_rnd: "moderate_attack",
             move_heal: "heal"
           }
  end
end
