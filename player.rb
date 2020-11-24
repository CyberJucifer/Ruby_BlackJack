require_relative 'players.rb'
class Player < Players

attr_accessor :dealer

  def initialize(name)
    super
    @dealer = Dealer.new
  end

  def skip
    dealer.make_choice
  end

  def add_card
    raise "Player doesn't have 2 cards!" unless self.cards >=2
    self.cards << Card.new
  end

  def show_cards
    
  end

end
