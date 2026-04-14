class WrongNumberOfPlayersError < StandardError; end
class NoSuchStrategyError < StandardError; end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  player1, player2 = game
  strategy1 = player1[1].to_s.upcase
  strategy2 = player2[1].to_s.upcase
  valid_strategies = %w[R P S]

  unless valid_strategies.include?(strategy1) && valid_strategies.include?(strategy2)
    raise NoSuchStrategyError
  end

  winning_strategy = {
    "R" => "S",
    "S" => "P",
    "P" => "R"
  }

  strategy1 == strategy2 || winning_strategy[strategy1] == strategy2 ? player1 : player2
end
