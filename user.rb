# frozen_string_literal: true

# User
class User
  attr_accessor :name, :bank, :cards

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
  end

  def take_card(hand)
    cards << hand.cards.shift
  end
end
