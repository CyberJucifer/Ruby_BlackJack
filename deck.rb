# frozen_string_literal: true

# Deck
class Deck
  CARD_SUITS = %w[♣ ♠ ♥ ♦].freeze
  CARD_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :cards

  def initialize
    @cards = generate_cards
  end

  private

  def generate_cards
    cards = []
    CARD_SUITS.each do |suit|
      CARD_VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle
  end
end
