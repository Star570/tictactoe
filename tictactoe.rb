def initialize_board
  s = (1..9).map{|x| x.to_s } # => [1, 2, 3, 4, 5, 6, 7, 8, 9] 
  b = {}
  (1..9).each {|position| b[position] = "(" + s[position-1] + ")"}
  b #=> {1=>1, 2=>2, 3=>3, 4=>4, 5=>5, 6=>6, 7=>7, 8=>8, 9=>9} 
end

def draw_board(b)
  system 'clear'
  puts " #{b[1]} | #{b[2]} | #{b[3]} " 
  puts "-----------------"
  puts " #{b[4]} | #{b[5]} | #{b[6]} " 
  puts "-----------------"
  puts " #{b[7]} | #{b[8]} | #{b[9]} " 
end

def empty_positions(b)
  b.select {|k, v| v != ' O ' && v != ' X '}.keys
end

def player_picks_another_positions(b)
  puts "Warning!!! Please pick another position:"
  position = gets.chomp.to_i
  if position == 1 || position == 2 || position == 3 || position == 4 || position == 5 || position == 6 || position == 7 || position == 8 || position == 9
    if b[position] != ' O ' && b[position] != ' X ' 
      b[position] = ' O '
    else
      player_picks_another_positions(b)
    end
  else
    player_picks_another_positions(b)
  end
end

def player_picks_positions(b)
  puts "Pick a position (1 - 9):"
  position = gets.chomp.to_i
  if position == 1 || position == 2 || position == 3 || position == 4 || position == 5 || position == 6 || position == 7 || position == 8 || position == 9
    if b[position] != ' O ' && b[position] != ' X ' 
      b[position] = ' O '
    else
      player_picks_another_positions(b)
    end
  else
    player_picks_another_positions(b)
  end
end

def computer_picks_positions(b)
  position = empty_positions(b).sample
  b[position] = ' X '
end

def check_winner(b)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    if b[line[0]] == ' O ' && b[line[1]] == ' O ' && b[line[2]] == ' O '
      return "Player"
    elsif b[line[0]] == ' X ' && b[line[1]] == ' X ' && b[line[2]] == ' X '
      return "Computer"
    else
      nil
    end
  end
end

def play_again
  puts "Play again?(y/n)"
  ans = gets.chomp.downcase
  if ans == 'y'
    game_loop
  elsif ans == 'n'
    exit
  else
    play_again
  end
end

def game_loop
  board = initialize_board
  draw_board(board)
  begin
    player_picks_positions(board)
    computer_picks_positions(board)
    draw_board(board)
    winner = check_winner(board)  
  end until winner == "Player" || winner == "Computer" || empty_positions(board).empty?
  if winner == "Player"
    puts "You won!"
    play_again
  elsif winner == "Computer"
    puts "Computer won!"
    play_again
  else
    puts "It's a tie!"
    play_again
  end
end


game_loop






