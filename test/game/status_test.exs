defmodule ExMon.Game.StatusTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game
  alias ExMon.Game.Status
  alias ExMon.Player

  describe "print_round_message/1" do
    setup do
      player = ExMon.create_player("Felipe", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "print started message" do
      message = capture_io(fn -> Status.print_round_message(Game.info()) end)

      assert message =~ "the game is started!"
      assert message =~ "status: :started"
    end

    test "print continue message" do
      currency_state = Game.info()
      new_state = Map.put(currency_state, :computer, %Player{life: 70})

      Game.update(new_state)

      message = capture_io(fn -> Status.print_round_message(Game.info()) end)

      assert message =~ "it's computer turn"
      assert message =~ "status: :continue"
    end

    test "print game over message" do
      currency_state = Game.info()
      computer_with_zero_life = %Player{life: 0}
      new_state = %{currency_state | turn: :computer, computer: computer_with_zero_life}

      Game.update(new_state)

      message = capture_io(fn -> Status.print_round_message(Game.info()) end)

      assert message =~ "The Game is Over"
    end
  end

  describe "print_wrong_move_message/1" do
    test "when is an invalid move, print wrong message" do
      expected_response = "Invalid Move: wrong"

      message =
        capture_io(fn ->
          Status.print_wrong_move_message(:wrong)
        end)

      assert message =~ expected_response
    end
  end

  describe "print_move_message/3" do
    test "print when player is attack computer" do
      message =
        capture_io(fn ->
          Status.print_move_message(:computer, :attack, 20)
        end)

      assert message =~ "The Player attacked the Computer dealing 20 damage"
    end

    test "print when computer is attack player" do
      message =
        capture_io(fn ->
          Status.print_move_message(:player, :attack, 20)
        end)

      assert message =~ "The Computer attacked the Player dealing 20 damage"
    end

    test "print when player is healing" do
      message =
        capture_io(fn ->
          Status.print_move_message(:player, :heal, 75)
        end)

      assert message =~ "The player is healing 75 points"
    end
  end
end
