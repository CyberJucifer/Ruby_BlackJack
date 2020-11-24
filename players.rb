class Players

  include PointsCounter
  attr_accessor :name, :bank, :cards

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    2.times do
      new_card = Card.new
      @cards << new_card
    end
    register_points
  end

  def take_card
    raise "Player doesn't have 2 cards!" unless cards >=2
    cards << Card.new
    register_points
  end

end
