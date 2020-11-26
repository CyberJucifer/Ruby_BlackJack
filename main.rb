# frozen_string_literal: true

require_relative 'players'
require_relative 'player'
require_relative 'card'
require_relative 'dealer'
# Main interface
class Main
  attr_accessor :player, :dealer, :game_over, :game_bank, :play_again

  def initialize
    @game_over = false
    @play_again = false
    @game_bank = 0
  end

  def start_game
    show_greetings
    make_bets
    loop { play }
  end

  protected

  def play
    do_play_again if play_again
    self.game_over = true if player.cards.size > 2 && dealer.cards.size > 2
    if game_over
      show_game_over_interface
    else
      show_interface
    end
    return unless !play_again && !game_over

    show_choice_menu
    choice_menu_operations
  end

  def show_greetings
    puts 'Введите ваше имя:'
    @player = Player.new(gets.chomp)
    raise 'Name can not be empty!' if player.name.empty?

    @dealer = Dealer.new
    puts "Привет, #{player.name}! Игра начинается!"
  end

  def show_game_over_interface
    show_result if game_over
    show_interface
    if player.bank.zero? || dealer.bank.zero?
      puts 'Игра окончена! У одного из игроков не осталось денег!'
      exit
    end
    show_play_again_menu
    play_again_menu_operations
  end

  def do_play_again
    player.cards.clear
    dealer.cards.clear
    player.take_first_cards
    dealer.take_first_cards
    make_bets
    self.play_again = false
  end

  def show_interface
    puts dealer_interface
    puts "\t\t\t Банк игры: #{game_bank}$"
    puts player_interface
  end

  def dealer_interface
    print "Карты дилера: \t"
    if game_over
      show_cards(dealer)
      print "\t Очки дилера: #{dealer.points}"
    else
      dealer.cards.each { print '*' }
      print "\t Очки дилера: **"
    end
    print " Банк дилера: #{dealer.bank}$"
  end

  def player_interface
    print "Ваши карты: \t"
    show_cards(player)
    print "\t Ваши очки: #{player.points}"
    print "\t Ваш банк: #{player.bank}$"
  end

  def show_choice_menu
    puts 'Введите 1, чтобы взять карту'
    puts 'Введите 2, чтобы открыть карты'
    puts 'Введите 3, чтобы пропустить ход'
    puts 'Введите 0, чтобы закончить игру'
  end

  def choice_menu_operations
    case make_choice
    when 1
      return puts 'Игрок достиг максимального количества карт!' if player.cards.size == 3

      player.take_card
      dealer.make_choice
    when 2
      self.game_over = true
    when 3
      dealer.make_choice
    when 0
      exit
    end
  end

  def show_result
    if (player.points > dealer.points && player.points <= 21) || (player.points <= 21 && dealer.points > 21)
      puts "Вы победили и получили #{game_bank}$ в свой банк!"
      count_result(player)
    elsif (dealer.points > player.points && player.points <= 21) || (dealer.points <= 21 && player.points > 21)
      puts "Вы проиграли! Дилер получает #{game_bank}$ в свой банк!"
      count_result(dealer)
    else
      puts 'Ничья! Деньги из банка игры возвращаются своим владельцам!'
      count_result(player, true)
      count_result(dealer, true)
    end
  end

  def count_result(player_or_dealer, draw = false)
    return player_or_dealer.bank += 10 unless draw == false

    player_or_dealer.bank += game_bank
    self.game_bank = 0
  end

  def show_play_again_menu
    puts 'Введите 1, чтобы сыграть еще раз'
    puts 'Введите 0, чтобы закончить игру'
  end

  def play_again_menu_operations
    case make_choice
    when 1
      self.play_again = true
      self.game_over = false
    when 0
      exit
    end
  end

  def show_cards(dealer_or_player)
    dealer_or_player.cards.each { |card| print "#{card.name} " }
  end

  def make_choice
    gets.chomp.to_i
  end

  def make_bets
    self.game_bank += 20
    player.bank -= 10
    dealer.bank -= 10
  end
end

Main.new.start_game
