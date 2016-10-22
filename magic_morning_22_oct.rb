def sort_rubies(input, players)
  # shares = Array.new(players, [])
  shares = []
  target = input.reduce(:+)/players
  players.times do
    shares << [0]
  end

  until input.length == 0
    if shares[0].reduce(:+) < shares[1].reduce(:+)
      shares[0] << input.pop
    elsif shares[0].reduce(:+) > shares[1].reduce(:+)
      shares[1] << input.pop
    else
      shares[1] << input.pop
    end
  end


  # if any number differential between two numbers == targetdiff, switch em
  if shares[0].reduce(:+) > shares[1].reduce(:+)
    higher_value_array = shares[0]
    lower_value_array = shares[1]
  else
    higher_value_array = shares[1]
    lower_value_array = shares[0]
  end

  target_differential = ((shares[0].reduce(:+) - shares[1].reduce(:+)) / 2).abs

  higher_value_array.each do |num1|
    lower_value_array.each do |num2|
      if num1 - num2 == target_differential
        first_num_to_switch = num1
        second_num_to_switch = num2
        # doesn't account for duplicate numbers in array
        higher_value_array.delete_if{ |x| x == first_num_to_switch}
        lower_value_array.push(first_num_to_switch)
        lower_value_array.delete_if{ |x| x == second_num_to_switch}
        higher_value_array.push(second_num_to_switch)
      end
    end
  end


  sum_totals(higher_value_array, lower_value_array)
  check_for_easy_win(shares)

end

def sum_totals(higher_value_array, lower_value_array)
  puts "1: #{higher_value_array.reduce(:+)}"
  puts "1: #{higher_value_array}"
  puts
  puts "2: #{lower_value_array.reduce(:+)}"
  puts "2: #{lower_value_array}"
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
