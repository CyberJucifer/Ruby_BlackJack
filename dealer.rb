# frozen_string_literal: true

# Dealer
class Dealer < User
  def initialize(name = 'Dealer')
    super
  end

  def make_choice(deck)
    take_card(deck) if hand.cards_count_score < 17 && hand.cards.size != 3
  end
end
