defmodule ExMon.Game.Actions.HealTest do
  use ExUnit.Case

  import ExUnit.CaptureIO
  import ExMon.Helpers.StateUpdateTest

  alias ExMon.Game
  alias ExMon.Game.Actions.Heal

  describe "heal_yourself/1" do
    setup do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when player is healing" do
      update_player_life(:player, 80)

      message = capture_io(fn -> Heal.heal_yourself(:player) end)

      state = Game.info()

      assert message =~ "The player is healing"
      refute state.player.life == 80
    end

    test "see if the player life will exceed limit" do
      message = capture_io(fn -> Heal.heal_yourself(:player) end)

      assert message =~ "The player is healing 100 points"
    end
  end
end
