defmodule ExMon.Game do
  @moduledoc false

  use Agent

  alias ExMon.Player

  def start(computer, player) do
    initial_value = %{
      computer: computer,
      player: player,
      turn: :player,
      status: :started
    }

    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end

  def update(state) do
    Agent.update(
      __MODULE__,
      fn _ ->
        update_game_status(state)
        |> Map.put(:turn, update_turn(state.turn))
      end
    )
  end

  defp update_game_status(
         %{player: %Player{life: player_life}, computer: %Player{life: computer_life}} = state
       )
       when player_life == 0 or computer_life == 0 do
    Map.put(state, :status, :game_over)
  end

  defp update_game_status(state) do
    Map.put(state, :status, :continue)
  end

  defp update_turn(turn) do
    case turn do
      :player -> :computer
      :computer -> :player
    end
  end

  def turn, do: Map.get(info(), :turn)
  def fetch_player(player), do: Map.get(info(), player)
end
