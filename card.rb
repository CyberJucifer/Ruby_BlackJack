# frozen_string_literal: true

# Card
class Card
  attr_reader :value, :suit

  def initialize(suit, value)
    @value = value
    @suit = suit
  end
end
