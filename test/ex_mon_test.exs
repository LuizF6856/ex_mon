defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO
  import ExMon.Helpers.StateUpdateTest

  alias ExMon.Player

  describe "create_player/4" do
    test "create a player" do
      expected_response = %Player{
        name: "Felipe",
        life: 100,
        moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
      }

      assert expected_response == ExMon.create_player("Felipe", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game started, returns a message" do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      message =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert message =~ "the game is started!"
      assert message =~ "status: :started"
      assert message =~ "Felipe"
    end
  end

  describe "make_action/1" do
    setup do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the game is valid, do the move and the computer makes a move" do
      message =
        capture_io(fn ->
          ExMon.make_action(:chute)
        end)

      assert message =~ "The Player attacked the Computer"
      assert message =~ "it's computer turn"
      assert message =~ "it's player turn"
      assert message =~ "status: :continue"
    end

    test "make the heal action" do
      message =
        capture_io(fn ->
          ExMon.make_action(:cura)
        end)

      assert message =~ "The player is healing"
    end

    test "when move is invalid, returns an error" do
      message =
        capture_io(fn ->
          ExMon.make_action(:wrong)
        end)

      assert message =~ "Invalid Move: wrong"
    end

    test "when the game is over" do
      update_player_life(:computer, 1)

      message =
        capture_io(fn ->
          ExMon.make_action(:soco)
        end)

      assert message =~ "The Game is Over"
    end
  end
end
