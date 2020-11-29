# frozen_string_literal: true

# Dealer
class Dealer < User
  def initialize(name = 'Dealer')
    super
  end

  def make_choice(hand)
    take_card(hand) if hand.cards_count_score(cards) < 17 && cards.size != 3
  end
end
