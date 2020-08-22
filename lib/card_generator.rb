require './lib/card'

class CardGenerator
  attr_reader :filename, :cards_array

  def initialize(filename)
    @filename = File.open(filename)
    @cards_array = @filename.readlines.map(&:chomp)
  end

  def cards
    split_array = []
    @cards_array.map {|card| split_array << card.split(', ')}
    split_array.map do |value, suit, rank|
      Card.new(suit.downcase.to_sym, value, rank.to_i)
    end
  end

end
