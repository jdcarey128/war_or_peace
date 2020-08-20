class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    @cards[index].rank
  end

  def high_ranking_cards
    @cards.select {|card| card.rank > 10}
  end

  def percent_high_ranking
    convert_to_percent(high_ranking_cards.length.to_f / @cards.length)
  end

  def convert_to_percent(number)
    (number * 100).round(2)
  end

  def remove_card
    @cards.shift
  end

  def add_card(card)
    @cards.push(card)
  end

end
