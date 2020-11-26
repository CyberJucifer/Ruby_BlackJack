# frozen_string_literal: true

# Players
class Players
  attr_accessor :name, :bank, :cards, :points

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    take_first_cards
  end

  def take_first_cards
    2.times { cards << Card.new }
    cards_count_score
  end

  def skip
    if name == 'Dealer'
      player.make_choice
    else
      dealer.make_choice
    end
  end

  def take_card
    raise "Player doesn't have 2 cards!" unless cards.size >= 2

    cards << Card.new
    cards_count_score
  end

  protected

  def cards_count_score
    sum = 0
    ace_count = 0
    cards.each do |card|
      if card.name =~ (/^[JKQ]{1}/)
        sum += 10
      elsif card.name =~ (/^[0-9]{1}/)
        sum += card.name.to_i
      else
        sum += 1
        ace_count += 1
      end
    end
    ace_count.times { sum += 10 if sum + 10 <= 21 }
    @points = sum
  end
end
