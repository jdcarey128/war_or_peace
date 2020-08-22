require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'



class PlayerTest < Minitest::Test

  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([@card1, @card2, @card3])
    @deck2 = Deck.new([@card1,@card2])
    @player = Player.new('Clarisa', @deck)
    @player2 = Player.new('Claris', @deck2)
  end

  def test_it_exists

    assert_instance_of Player, @player
  end

  def test_it_can_return_rank_of_first_card

    assert_equal 12, @player.rank_of_first_card
  end

  def test_it_can_return_rank_of_third_card

    assert_equal 14, @player.rank_of_third_card
  end

  def test_it_can_return_nil_if_third_card_is_not_there

    assert_nil @player2.rank_of_third_card
  end

  def test_it_can_return_top_three_cards

    assert_equal @deck.cards, @player.top_three_cards
  end

  def test_it_can_return_amount_of_cards

    assert_equal 3, @deck.cards.length
  end

  def test_player_has_attributes

    assert_equal "Clarisa", @player.name
    assert_equal @deck, @player.deck
  end

  def test_player_has_not_lost

    assert_equal false, @player.has_lost?
  end

  def test_player_loses_top_card

    assert_equal @card1, @player.deck.remove_card
  end

  def test_player_loses_when_cards_are_gone

    assert_equal false, @player.has_lost?

    @player.deck.remove_card
    @player.deck.remove_card
    @player.deck.remove_card
    assert_equal true, @player.has_lost?
  end

end
