# frozen_string_literal: true

# Output interface
module Output
  def game_greetings
    puts 'Введите ваше имя:'
  end

  def valid_name
    raise 'Name can not be empty!' if player.name.empty?
  end

  def player_greetings(player)
    puts "Привет, #{player.name}! Игра начинается!"
  end

  def out_of_money
    puts 'Игра окончена! У одного из игроков не осталось денег!'
  end

  def show_interface
    puts dealer_interface
    puts "Банк игры: #{bank}$"
    puts player_interface
  end

  def dealer_interface
    print "Карты дилера: \t"
    if game_over
      show_cards(dealer)
      print "\t Очки дилера: #{hand.cards_count_score(dealer.cards)}"
    else
      dealer.cards.each { print '*' }
      print "\t Очки дилера: **"
    end
    print " Банк дилера: #{dealer.bank}$"
  end

  def player_interface
    print "Ваши карты: \t"
    show_cards(player)
    print "\t Ваши очки: #{hand.cards_count_score(player.cards)}"
    print "\t Ваш банк: #{player.bank}$"
  end

  def show_choice_menu
    puts 'Введите 1, чтобы взять карту'
    puts 'Введите 2, чтобы открыть карты'
    puts 'Введите 3, чтобы пропустить ход'
    puts 'Введите 0, чтобы закончить игру'
  end

  def show_play_again_menu
    puts 'Введите 1, чтобы сыграть еще раз'
    puts 'Введите 0, чтобы закончить игру'
  end

  def you_win
    puts "Вы победили и получили #{bank}$ в свой банк!"
  end

  def you_lost
    puts "Вы проиграли! Дилер получает #{bank}$ в свой банк!"
  end

  def max_cards
    puts 'Игрок достиг максимального количества карт!'
  end

  def show_cards(dealer_or_player)
    dealer_or_player.cards.each { |card| print card.value, card.suit }
  end

  def draw
    puts 'Ничья! Деньги из банка игры возвращаются своим владельцам!'
  end
end
