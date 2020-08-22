class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if first_card_not_equal
      :basic
    elsif third_card_not_equal
      :war
    else
      :mutually_assured_destruction
    end
  end

  def first_card_not_equal
    @player1.rank_of_first_card != @player2.rank_of_first_card
  end

  def third_card_not_equal
    @player1.rank_of_third_card != @player2.rank_of_third_card
  end

  def winner
    if type == :basic
      return player1.name if @player1.rank_of_first_card > @player2.rank_of_first_card
      return player2.name if @player1.rank_of_first_card < @player2.rank_of_first_card
    elsif type == :war
      return player1.name if @player1.rank_of_third_card > @player2.rank_of_third_card
      return player2.name if @player1.rank_of_third_card < @player2.rank_of_third_card
    else
      "No Winner"
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    elsif type == :war
      @spoils_of_war << player1.top_three_cards
      @spoils_of_war << player2.top_three_cards
      @spoils_of_war.flatten!
      3.times {player1.deck.remove_card}
      3.times {player2.deck.remove_card}
    else
      3.times {player1.deck.remove_card}
      3.times {player2.deck.remove_card}
    end
  end

  def award_spoils(winner_arg)
    if winner_arg == player1.name
      (player1.deck.add_card(@spoils_of_war)).flatten!
      @spoils_of_war = []
    else
      (player2.deck.add_card(@spoils_of_war)).flatten!
      @spoils_of_war = []
    end
  end

  def start_gameplay
    until player1.has_lost? || player2.has_lost?
      turn_count = 1
      if type == :basic
        pile_cards
        p "Turn #{turn_count}: #{winner} won #{@spoils_of_war.length} cards"
        award_spoils(winner)
      elsif type == :war
        pile_cards
        p "Turn #{turn_count}: WAR - #{winner} won #{@spoils_of_war.length} cards"
        award_spoils(winner)
      else
        pile_cards
        p "Turn #{turn_count}: *mutually assured destruction* 6 cards removed from play"
      end
      turn_count += 1
    end
  end
end
