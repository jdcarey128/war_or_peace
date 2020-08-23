require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'


class TurnTest < Minitest::Test

  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @card9 = Card.new(:heart, '8', 8)

    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @deck1_war = Deck.new([@card1, @card2, @card5, @card8])
    @deck2_war = Deck.new([@card4, @card3, @card6, @card7])
    @deck1_dest = Deck.new([@card1, @card2, @card5, @card8])
    @deck2_dest = Deck.new([@card4, @card3, @card9, @card7])

    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @player1_war = Player.new("Megan", @deck1_war)
    @player2_war = Player.new("Aurora", @deck2_war)
    @player1_dest = Player.new("Megan", @deck1_dest)
    @player2_dest = Player.new("Aurora", @deck2_dest)

    @turn = Turn.new(@player1, @player2)
    @turn_war = Turn.new(@player1_war, @player2_war)
    @turn_dest = Turn.new(@player1_dest, @player2_dest)
  end

  def test_it_exists

    assert_instance_of Turn, @turn
  end

  def test_it_returns_turn_player_and_spoils_attributes

    assert_equal @player1, @turn.player1
    assert_equal @player2, @turn.player2
    assert_equal [], @turn.spoils_of_war
  end

  def test_it_can_determine_type_is_basic

    assert_equal :basic, @turn.type
  end

  def test_it_can_determine_winner

    assert_equal "Megan", @turn.winner
  end

  def test_pile_cards_can_send_cards_to_spoils_of_war

    @turn.pile_cards

    assert_equal [@card1, @card3], @turn.spoils_of_war
  end

  def test_winner_receives_spoils_of_war

    winner = @turn.winner
    @turn.pile_cards
    @turn.award_spoils(winner)

    player1_cards = [@card2, @card5, @card8, @card1, @card3]
    player2_cards = [@card4, @card6, @card7]

    assert_equal player1_cards, @player1.deck.cards
    assert_equal player2_cards, @player2.deck.cards
  end

  def test_it_determines_type_is_war

    assert_equal :war, @turn_war.type
  end

  def test_it_determines_winner_in_war

    assert_equal "Aurora", @turn_war.winner
  end

  def test_pile_cards_returns_top_three_cards_to_spoils_in_war

    @turn_war.pile_cards
    each_top_three = [@card1, @card2, @card5, @card4, @card3, @card6]

    assert_equal each_top_three, @turn_war.spoils_of_war
    assert_equal [@card8], @player1_war.deck.cards
    assert_equal [@card7], @player2_war.deck.cards
  end

  def test_it_returns_spoils_of_war_to_winner

    winner = @turn_war.winner
    @turn_war.pile_cards
    @turn_war.award_spoils(winner)
    winner_cards = [@card7, @card1, @card2, @card5, @card4, @card3, @card6]

    assert_equal [@card8], @player1_war.deck.cards
    assert_equal winner_cards, @player2_war.deck.cards
  end

  def test_it_returns_mutually_assured_destruction_type

    assert_equal :mutually_assured_destruction, @turn_dest.type
    assert_equal @player1_dest.deck.rank_of_card_at(2), @player2_dest.deck.rank_of_card_at(2)
  end

  def test_winner_returns_no_winner

    assert_equal "No Winner", @turn_dest.winner
  end

  def test_pile_cards_does_not_return_cards_to_spoils

    @turn_dest.pile_cards

    assert_equal [], @turn_dest.spoils_of_war
    assert_equal [@card8], @player1_dest.deck.cards
    assert_equal [@card7], @player2_dest.deck.cards
  end

  def test_update_player_decks_are_minus_top_three_cards

    @turn_dest.pile_cards


    assert_equal [@card8], @player1_dest.deck.cards
    assert_equal [@card7], @player2_dest.deck.cards
  end

  def test_game_ends_when_player_does_not_have_enough_cards_type_war

    @turn_war.gameplay

    assert_equal "Aurora", @turn_war.winner
  end

  def test_game_ends_when_player_does_not_have_enough_cards_type_mutually_destructive

    @turn_dest.gameplay
    winner = @turn_dest.winner
    game_winner = @turn_dest.game_winner

    assert_equal "Aurora", winner
    assert_equal "*~*~*~* Aurora has won the game! *~*~*~*", game_winner
  end

end
