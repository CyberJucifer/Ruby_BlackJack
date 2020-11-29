# frozen_string_literal: true

# Hand
class Hand
  attr_accessor :cards

  def initialize
    @cards = Deck.new.cards
  end

  def cards_count_score(cards)
    sum = 0
    ace_count = 0
    cards.each do |card|
      if card.value =~ /^[JKQ]{1}/
        sum += 10
      elsif card.value =~ /^[0-9]{1}/
        sum += card.value.to_i
      else
        sum += 1
        ace_count += 1
      end
    end
    ace_count.times { sum += 10 if sum + 10 <= 21 }
    sum
  end
end
