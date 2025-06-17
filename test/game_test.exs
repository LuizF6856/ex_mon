defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build_player("Felipe", :chute, :soco, :cura)
      computer = Player.build_player("Radahn", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "return the current game state" do
      player = Player.build_player("Felipe", :chute, :soco, :cura)
      computer = Player.build_player("Radahn", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        player: %Player{
          life: 100,
          name: "Felipe",
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
        },
        computer: %Player{
          life: 100,
          name: "Radahn",
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura}
        },
        turn: :player,
        status: :started
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    setup do
      player = Player.build_player("Felipe", :chute, :soco, :cura)
      computer = Player.build_player("Radahn", :chute, :soco, :cura)

      Game.start(computer, player)

      :ok
    end

    test "returns the game state updated" do
      current_state = Game.info()

      assert 100 == current_state.computer.life

      update_computer_life = Map.put(current_state.computer, :life, 80)

      new_state = Map.put(current_state, :computer, update_computer_life)

      assert :ok == Game.update(new_state)

      state = Game.info()

      assert 80 == state.computer.life
    end

    test "returns the turn updated" do
      current_state = Game.info()

      assert :player == current_state.turn

      update_computer_life = Map.put(current_state.computer, :life, 80)

      new_state = Map.put(current_state, :computer, update_computer_life)

      assert :ok == Game.update(new_state)

      state = Game.info()

      assert :computer == state.turn
    end

    test "returns the status updated to continue" do
      current_state = Game.info()

      assert :started == current_state.status

      update_computer_life = Map.put(current_state.computer, :life, 80)

      new_state = Map.put(current_state, :computer, update_computer_life)

      assert :ok == Game.update(new_state)

      state = Game.info()

      assert :continue == state.status
    end

    test "return status game over" do
      current_state = Game.info()

      assert :started == current_state.status

      update_computer_life = Map.put(current_state.computer, :life, 0)

      new_state = Map.put(current_state, :computer, update_computer_life)

      assert :ok == Game.update(new_state)

      state = Game.info()

      assert :game_over == state.status
    end
  end

  describe "turn/0 and fetch_player/1" do
    setup do
      player = Player.build_player("Felipe", :chute, :soco, :cura)
      computer = Player.build_player("Radahn", :chute, :soco, :cura)

      Game.start(computer, player)

      :ok
    end

    test "turn" do
      assert :player == Game.turn()
    end

    test "fetch_player" do
      player_info = Game.fetch_player(:player)

      assert "Felipe" == player_info.name
      assert 100 == player_info.life
      assert :soco == player_info.moves.move_avg
    end
  end
end
