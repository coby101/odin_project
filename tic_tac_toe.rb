require './bin/tic_tac_toe_board.rb'
require './bin/player.rb'

def play_tic_tac_toe
  board = TicTacToeBoard.new
  current = 0
  players = splash_screen(welcome_players(2, 1))
  puts 'Press enter to continue';
  gets
  board.display
  until board.full? || board.winner
    play = get_play players[current % 2].name
    begin
      board.record_play(players[current % 2].token, play[0], play[1])
      board.display
      current += 1
    rescue StandardError => e
      puts e.message
    end
  end
  puts 'Game over!!'
  board.winner ? (puts "The winner is #{players[(current % 2) % 1].name}") : (puts 'It was a tie')
  puts "\nThanks for playing. Goodbye."
end

def welcome_players(num, tok_len)
  puts 'Welcome to Newbie Ruby Tic Tac Toe!'
  puts "Let's get some details on who's playing..."
  Player.create_players num, tok_len
  puts "\nGreat, thanks\n\n"
end

def splash_screen(players)
  puts 'On each turn, examine the board and then enter your play as an a, b or c for '
  puts 'the row and 1, 2 or 3 for the column. For example, enter "a 1" (without the '
  puts "quotations) for the top left corner, and \"c 3\" for the bottom right corner.\n\n"
  players.each do |p|
    puts "#{p.name} will be represented with \"#{p.token}\""
  end
  puts "\n"
  players
end

def get_play(name)
  move = nil
  until move
    print "Please make your move, #{name}: "
    input = gets.chomp
    move = input.squeeze(' ').strip.downcase.split
    unless move.length == 2
      puts "Can't make sense of \"#{input}.\" Enter something from \"a 1\" to \"c 3\" (without the quotes)"
      move = nil
    end
  end
  move
end

play_tic_tac_toe
