# frozen_string_literal: true

# User
class User
  attr_accessor :name, :bank, :hand

  def initialize(name)
    @name = name
    @bank = 100
    @hand = Hand.new
  end

  def take_card(deck)
    hand.cards << deck.cards.shift
  end
end
