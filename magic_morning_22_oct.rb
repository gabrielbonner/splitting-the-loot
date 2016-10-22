def sort_rubies(input, players)
  # shares = Array.new(players, [])
  shares = []
  target = input.reduce(:+)/players
  players.times do
    shares << [0]
  end

  until input.length == 0
    # if any of the values in input = target - either player's current total
      # give that value to that player
    if shares[0].reduce(:+) < shares[1].reduce(:+)
      shares[0] << input.pop
    elsif shares[0].reduce(:+) > shares[1].reduce(:+)
      shares[1] << input.pop
    else
      shares[1] << input.pop
    end
  end

  sum_totals(shares)
  check_for_easy_win(shares)

end

def sum_totals(shares)
  puts "1: #{shares[0].reduce(:+)}"
  puts "1: #{shares[0]}"
  puts
  puts "2: #{shares[1].reduce(:+)}"
  puts "2: #{shares[1]}"
end

def check_for_easy_win(shares)
  # MVP, expand to take more than 2 players
  if shares[0].reduce(:+) == shares[1].reduce(:+)
    puts "Success!"
    puts "1: #{shares[0]}"
    puts "2: #{shares[1]}"
  end
end

input = ARGV
input.map! {|i| i.to_i}
players = input.shift
if players == 1
  puts "You win!"
else
  total = input.reduce(:+)
  if total % players != 0
    puts "It is not possible to fairly split this treasure #{players} ways."
  else
    sort_rubies(input, players)
  end
end
