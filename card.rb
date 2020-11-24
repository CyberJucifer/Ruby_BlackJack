class Card

  attr_accessor :name, :value

  CARD_SUIT = ['♣', '♠', '♥', '♦']
  DECK = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']
  def initialize
    @name = random_card
    @value = determine_value(name)
  end

  def random_card
    DECK[rand(DECK.size)] + CARD_SUIT[rand(CARD_SUIT.size)]
  end

  def determine_value(name)
    if name =~ (/^[JKQ]{1}/)
      10
    elsif name =~ (/^[0-9]{1}/)
      name.to_i
    else
      [1,11]
    end
  end

end
