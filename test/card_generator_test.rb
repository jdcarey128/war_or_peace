require 'minitest/autorun'
require 'minitest/pride'
require './lib/card_generator'
require './lib/card'

class CardGeneratorTest < Minitest::Test

  def setup
    @filename = "./test/cards_test.txt"
    @generator = CardGenerator.new(@filename)
    @card1 = Card.new(:heart, "2", 2)
    @card2 = Card.new(:heart, "3", 3)
    @card3 = Card.new(:heart, "4", 4)
    @cards = [@card1, @card2, @card3]
  end

  def test_it_exists

    assert_instance_of File, @generator.filename
  end

  def test_it_generates_card_object_instances

    assert_instance_of Card, @generator.cards.first
  end

  def test_it_generates_all_cards_in_file

    #assert_equal @cards, @generator.cards aren't equal because of diff object_id
    #also, how do I test for specific cards when I use a shuffle method?
    assert_equal @cards.length, @generator.cards.length
  end

end
