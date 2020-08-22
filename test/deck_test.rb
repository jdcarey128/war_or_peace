require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'

class DeckTest < Minitest::Test

  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @cards = [@card1, @card2, @card3]
    @deck_test = Deck.new([])
    @deck = Deck.new(@cards)
    @card4 = Card.new(:club, '5', 5)

  end

  def test_it_exists

    assert_instance_of Deck, @deck
  end

  def test_deck_is_empty

    assert @deck_test.empty?
    assert_equal false, @deck.empty?
  end

  def test_deck_has_array_of_cards

    assert_equal @cards, @deck.cards
  end

  def test_card_rank_at_given_index

    assert_equal 12, @deck.rank_of_card_at(0)
    assert_equal 14, @deck.rank_of_card_at(2)
  end

  def test_card_rank_at_given_index_returns_nill

    assert_nil @deck.rank_of_card_at(3)
  end

  def test_identify_high_ranking_cards

    assert_equal [@card1, @card3], @deck.high_ranking_cards
  end

  def test_identify_percent_of_high_ranking_cards

    assert_equal [@card1, @card3], @deck.high_ranking_cards
    assert_equal 66.67, @deck.percent_high_ranking
  end

  def test_remove_first_card_in_deck

    assert_equal @card1, @deck.remove_card
    assert_equal [@card2, @card3], @deck.cards
  end

  def test_high_ranking_cards_after_removal

    @deck.remove_card

    assert_equal [@card3], @deck.high_ranking_cards
  end

  def test_percent_high_ranking_cards_after_removal

    @deck.remove_card

    assert_equal [@card3], @deck.high_ranking_cards
    assert_equal 50.0, @deck.percent_high_ranking
  end

  def test_add_card_to_deck

    @deck.remove_card

    assert_equal [@card2, @card3, @card4], @deck.add_card(@card4)
  end

  def test_high_ranking_cards_after_addition

    @deck.remove_card
    @deck.add_card(@card4)

    assert_equal [@card3], @deck.high_ranking_cards
  end

  def test_percent_high_ranking_cards_after_addition

    @deck.remove_card
    @deck.add_card(@card4)

    assert_equal [@card3], @deck.high_ranking_cards
    assert_equal 33.33, @deck.percent_high_ranking
  end

end
