require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

values_ranks = [['2', 2], ['3', 3], ['4', 4], ['5', 5], ['6', 6], ['7', 7],
['8', 8], ['9', 9], ['10', 10], ['Jack', 11], ['Queen', 12], ['King', 13], ['Ace', 14]]

#clone.map(&:clone) clones the array (has unique object_id) but also each element
diamond_cards = values_ranks.clone.map(&:clone)
heart_cards = values_ranks.clone.map(&:clone)
spade_cards = values_ranks.clone.map(&:clone)
club_cards = values_ranks.clone.map(&:clone)

diamond_cards.each {|array| array.unshift(:diamond)}
heart_cards.each {|array| array.unshift(:heart)}
spade_cards.each {|array| array.unshift(:spade)}
club_cards.each {|array| array.unshift(:club)}

cards = []

diamond_cards.shuffle.each do |suit, value, rank|
  cards << Card.new(suit, value, rank)
end

heart_cards.shuffle.each do |suit, value, rank|
  cards << Card.new(suit, value, rank)
end

spade_cards.shuffle.each do |suit, value, rank|
  cards << Card.new(suit, value, rank)
end

club_cards.shuffle.each do |suit, value, rank|
  cards << Card.new(suit, value, rank)
end

deck = Deck.new(cards.shuffle.shuffle)

player1 = Player.new("Megan", deck.cards[0..25])
player2 = Player.new("Aurora", deck.cards[26..52])

require "pry"; binding.pry
