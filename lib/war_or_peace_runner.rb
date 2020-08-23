require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/card_generator'

cards = CardGenerator.new("./lib/cards.txt").cards.shuffle.shuffle

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

turn.gameplay
