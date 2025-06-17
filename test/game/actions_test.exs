defmodule ExMon.Game.ActionsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Actions

  describe "attack/1" do
    test "when the player attack" do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      message =
        capture_io(fn ->
          ExMon.start_game(player)
          Actions.attack(:move_avg)
        end)

      assert message =~ "The Player attacked the Computer"
    end
  end

  describe "heal/0" do
    test "when the player is healing" do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      message =
        capture_io(fn ->
          ExMon.start_game(player)
          Actions.heal()
        end)

      assert message =~ "The player is healing"
    end
  end

  describe "fetch_move/2" do
    setup do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      capture_io(fn -> ExMon.start_game(player) end)

      :ok
    end

    test "when is a valid move" do
      assert {:ok, :move_avg} == Actions.fetch_move(:soco)
    end

    test "when is an invalid move" do
      assert {:error, :wrong} == Actions.fetch_move(:wrong)
    end
  end
end
