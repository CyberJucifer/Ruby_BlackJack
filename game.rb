# frozen_string_literal: true

# Game
class Game < Interface
  attr_accessor :player, :dealer, :game_over, :bank, :play_again, :deck, :interface

  def initialize
    game_greetings
    @player = Player.new(gets.chomp)
    valid_name
    @dealer = Dealer.new
    player_greetings
    start_game
  end

  def start_game
    @game_over = false
    @play_again = false
    @bank = 0
    @deck = Deck.new
    2.times { take_cards }
    make_bets
    loop { play }
  end

  protected

  def take_cards
    player.take_card(deck)
    dealer.take_card(deck)
  end

  def play
    do_play_again if play_again
    self.game_over = true if player.hand.cards.size > 2 && dealer.hand.cards.size > 2
    if game_over
      show_game_over_interface
    else
      show_interface
    end
    return unless !play_again && !game_over

    show_choice_menu
    choice_menu_operations
  end

  def show_game_over_interface
    show_result if game_over
    show_interface
    if player.bank.zero? || dealer.bank.zero?
      out_of_money
      exit
    end
    show_play_again_menu
    play_again_menu_operations
  end

  def clear_cards
    player.hand.cards.clear
    dealer.hand.cards.clear
  end

  def do_play_again
    self.deck = Deck.new
    clear_cards
    2.times { take_cards }
    make_bets
    self.play_again = false
  end

  def choice_menu_operations
    case make_choice
    when 1
      return max_cards if player.hand.cards.size == 3

      player.take_card(deck)
      dealer.make_choice(deck)
    when 2
      self.game_over = true
    when 3
      dealer.make_choice(deck)
    when 0
      exit
    end
  end

  def show_result
    if (count_points(player) > count_points(dealer) && count_points(player) <= 21) ||
       (count_points(player) <= 21 && count_points(dealer) > 21)
      you_win
      count_result(player)
    elsif (count_points(dealer) > count_points(player) && count_points(player) <= 21) ||
          (count_points(dealer) <= 21 && count_points(player) > 21)
      you_lost
      count_result(dealer)
    else
      draw
      count_result(player, true)
      count_result(dealer, true)
    end
  end

  def count_result(player_or_dealer, draw = false)
    return player_or_dealer.bank += 10 if draw

    player_or_dealer.bank += bank
    self.bank = 0
  end

  def count_points(user)
    user.hand.cards_count_score
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

  def make_bets
    self.bank += 20
    player.bank -= 10
    dealer.bank -= 10
  end
end
