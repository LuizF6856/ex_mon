defmodule ExMon do
  @moduledoc false

  alias ExMon.Game
  alias ExMon.Game.Actions
  alias ExMon.Game.Status
  alias ExMon.Player

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build_player(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    computer = create_player("Radahn", :soco, :chute, :cura)

    Game.start(computer, player)

    Status.print_round_message(Game.info())
  end

  def make_action(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_, move) do
    Actions.fetch_move(move)
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random([:move_avg, :move_rnd, :move_heal])}

    do_move(move)
  end

  defp computer_move(_), do: :ok
end
