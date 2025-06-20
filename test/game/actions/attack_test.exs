defmodule ExMon.Game.Actions.AttackTest do
  use ExUnit.Case

  import ExUnit.CaptureIO
  import ExMon.Helpers.StateUpdateTest

  alias ExMon.Game
  alias ExMon.Game.Actions.Attack

  describe "attack_opponent/2" do
    setup do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when player attack computer" do
      message =
        capture_io(fn ->
          Attack.attack_opponent(:computer, :move_avg)
        end)

      assert message =~ "The Player attacked the Computer dealing"
    end

    test "see if next attack of player update the computer life to zero instead of a negative number" do
      update_player_life(:computer, 5)

      message =
        capture_io(fn ->
          Attack.attack_opponent(:computer, :move_avg)
        end)

      state = Game.info()

      assert message =~ "The Player attacked the Computer dealing"
      assert state.computer.life == 0
    end
  end
end
