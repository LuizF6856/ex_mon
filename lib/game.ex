defmodule ExMon.Game do
  use Agent

  def start(computer, player) do
    initial_value = %{
      computer: computer,
      player: player,
      turn: :player
    }

    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end

  def update(state) do
    Agent.update(
      __MODULE__,
      fn _ -> Map.put(state, :turn, change_turn(state.turn)) end
    )
  end

  def turn, do: Map.get(info(), :turn)
  def fetch_player(player), do: Map.get(info(), player)

  def change_turn(turn) do
    case turn do
      :player -> :computer
      :computer -> :player
    end
  end
end
