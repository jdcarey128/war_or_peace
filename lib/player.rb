class Player
  attr_reader :name, :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def has_lost?
    @deck.empty?
  end

  def rank_of_first_card
    @deck.rank_of_card_at(0)
  end

  def rank_of_third_card
    @deck.rank_of_card_at(2)
  end

  def top_three_cards
    @deck.cards[0..2]
  end

  def amount_of_cards
    @deck.cards.length
  end

end
