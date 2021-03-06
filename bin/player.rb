# class for managing game players, consisting of a name and a token.
#  Basic validation for lenght and avoiding duplicate names and tokens.
class Player
  MAX_NAME_LEN = 40
  MAX_TOKEN_LEN = 10
  @@player_list = []

  attr_reader :name
  attr_reader :token

  def Player.create_players(num, token_len)
    players = []
    num.times do
      new_player = Player.new
      new_player.prompt_for_name
      new_player.prompt_for_token token_len
      players << new_player
    end
    players
  end

  def Player.list_players
    @@player_list.each do |p|
      puts "#{p.name}, represented by \"#{p.token}\""
    end
  end

  def Player.validate_name(name)
    raise 'No name supplied' if name == ''
    raise "Name is longer than maximum #{MAX_NAME_LEN} characters" if name.length > MAX_NAME_LEN
    raise "\"#{name}\" is taken. Please choose another." if @@player_list.any? { |p| p.name == name }

    name
  end

  def Player.validate_token(token, max_length)
    raise 'No token supplied' if token == '' && max_length.positive?
    raise "Token is longer than the maximum #{MAX_TOKEN_LEN} characters" if token.length > MAX_TOKEN_LEN
    raise "\"#{token}\" is taken. Please choose another." if @@player_list.any? { |p| p.token == token }

    token
  end

  def initialize(name = 'New Player', token = '')
    @name  =  name == 'New Player' ? name  : Player.validate_name(name)
    @token = token == ''           ? token : Player.validate_token(token, token.length)
    @@player_list.push self
  end

  def prompt_for_name
    raise "Player has a name already: \"#{@name}\". (Use 'rename' instead)" if @name != 'New Player'

    until @name != 'New Player'
      print "Enter your player's name (max #{MAX_NAME_LEN} characters): "
      begin
        @name = Player.validate_name gets.chomp.squeeze(' ').strip
      rescue StandardError => e
        puts e.message
      end
    end
    @name
  end

  def rename
    @name = 'New Player'
    prompt_for_name
  end

  def prompt_for_token(max_length)
    raise "Player has a token already: \"#{@token}\". (Use 'reset_token')" if @token != ''
    raise 'Token length <1 is not allowed' unless max_length.positive?

    until @token != ''
      print "Enter your player's token string (max #{max_length} character#{max_length == 1 ? '' : 's'}): "
      begin
        @token = Player.validate_token(gets.chomp.squeeze(' ').strip.slice(0..max_length - 1), max_length)
      rescue StandardError => e
        puts e.message
      end
    end
    @token
  end

  def reset_token(max_length)
    @token = ''
    prompt_for_token(max_length)
  end
end
