# frozen_string_literal: true

# Card
class Card
  attr_accessor :name

  CARD_SUIT = ['♣', '♠', '♥', '♦'].freeze
  DECK = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  def initialize
    @name = random_card
  end

  def random_card
    DECK[rand(DECK.size)] + CARD_SUIT[rand(CARD_SUIT.size)]
  end
end
