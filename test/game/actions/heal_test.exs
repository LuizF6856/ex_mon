defmodule ExMon.Game.Actions.HealTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game
  alias ExMon.Game.Actions.Heal
  alias ExMon.Player

  describe "heal_yourself/1" do
    setup do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when player is healing" do
      currency_state = Game.info()
      player_life = %Player{life: 80}
      new_state = %{currency_state | turn: :computer, player: player_life}

      Game.update(new_state)

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
