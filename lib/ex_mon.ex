defmodule ExMon do
  alias ExMon.Game.{Status, Actions}
  alias ExMon.{Game, Player}

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build_player(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    computer = create_player("Radahn", :soco, :chute, :cura)

    Game.start(computer, player)

    Status.print_round_message()
  end

  def make_action(move) do
    Actions.fetch_move(move)
  end
end
