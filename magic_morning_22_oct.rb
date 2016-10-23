def sort_rubies(input, players)

  # create 'players' in a nested array
  shares = []
  target = input.reduce(:+)/players
  players.times do
    shares << [0]
  end

  # roughly sort the rubies to get an approximate even value bewteen players
  # only works with 2 players at the moment
  until input.length == 0
    if shares[0].reduce(:+) < shares[1].reduce(:+)
      shares[0] << input.pop
    elsif shares[0].reduce(:+) > shares[1].reduce(:+)
      shares[1] << input.pop
    else
      shares[1] << input.pop
    end
  end


  #
  # only works for two players
  if shares[0].reduce(:+) > shares[1].reduce(:+)
    higher_value_array = shares[0]
    lower_value_array = shares[1]
  else
    higher_value_array = shares[1]
    lower_value_array = shares[0]
  end

  # find the target number that will equalize the shares
  # only works for two people at the moment
  target_differential = ((shares[0].reduce(:+) - shares[1].reduce(:+)) / 2).abs



  # check for a one-swap-winner-scenario
  # only works for two players
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

# to solve:
# generate all possible permutations of higher_value_array, push to new array1
# generate all possible permutations of lower_value_array, push to new array2
# if any of the possible permutations of array1 - array2 = target differential, print "There is a possible solution"
# now the hard part - figure out how to identify and switch the numbers that will give you the solution
# hint: use a hash table to store the total of each permutation as the key, and the value would be an array of the numbes that give that total.  Then you can go about switching the numbers in the the two value which correspond to the keys that give the target differential...easy peazy!


  pretty_print(higher_value_array, lower_value_array)
  check_for_win(shares)

end

def pretty_print(higher_value_array, lower_value_array)
  puts "1: #{higher_value_array.reduce(:+)}"
  puts "1: #{higher_value_array}"
  puts
  puts "2: #{lower_value_array.reduce(:+)}"
  puts "2: #{lower_value_array}"
end

def check_for_win(shares)
  # MVP, expand to take more than 2 players
  if shares[0].reduce(:+) == shares[1].reduce(:+)
    puts "Success!"
    puts "1: #{shares[0]}"
    puts "2: #{shares[1]}"
  end
end

####################### runner code ########################
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


#####################
##### test cases ########
#####################

# ruby magic_morning_22_oct.rb 2