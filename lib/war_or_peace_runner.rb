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

cards.shuffle.shuffle

deck1 = Deck.new(cards[0..25])
deck2 = Deck.new(cards[26..52])

deck_count = deck1.cards.length + deck2.cards.length

player1 = Player.new("Megan", deck1)
player2 = Player.new("Aurora", deck2)
turn = Turn.new(player1, player2)

puts """Welcome to War! (or Peace) This game will be played with #{deck_count} cards. The players today are #{player1.name} and #{player2.name}.
Type 'GO' to start the game!"""

start = gets.chomp.downcase

until start == "go"
  puts "Type 'GO' to start the game!"
  start = gets.chomp.downcase
end

turn.start_gameplay
