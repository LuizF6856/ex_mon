defmodule ExMon.Player do
  defstruct [:life, :name, :moves]

  def build_player(name, moderate_attack, variate_attack, heal) do
    %ExMon.Player{
      life: 100,
      name: name,
      moves: %{
        move_avg: variate_attack,
        move_rnd: moderate_attack,
        move_heal: heal
      }
    }
  end
end
