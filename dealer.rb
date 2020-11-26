# frozen_string_literal: true

require_relative 'players'

# Dealer
class Dealer < Players
  def initialize(name = 'Dealer')
    super
  end

  def make_choice
    take_card if points < 17 && cards.size != 3
  end
end
