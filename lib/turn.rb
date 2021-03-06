class Turn
  attr_reader :player1, :player2, :spoils_of_war, :turn_count

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @turn_count = 1
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
      if player1.rank_of_first_card == nil || player2.rank_of_first_card == nil
        return player2.name if @player1.rank_of_first_card == nil
        return player1.name if @player2.rank_of_first_card == nil
      else
        return player1.name if @player1.rank_of_first_card > @player2.rank_of_first_card
        return player2.name if @player1.rank_of_first_card < @player2.rank_of_first_card
      end
    elsif type == :war
      if player1.rank_of_third_card == nil || player2.rank_of_third_card == nil
        return player2.name if @player1.rank_of_third_card == nil
        return player1.name if @player2.rank_of_third_card == nil
      else
        return player1.name if @player1.rank_of_third_card > @player2.rank_of_third_card
        return player2.name if @player1.rank_of_third_card < @player2.rank_of_third_card
      end
    else
      if player1.rank_of_third_card == nil || player2.rank_of_third_card == nil
        return player2.name if @player1.rank_of_third_card == nil
        return player1.name if @player2.rank_of_third_card == nil
      else
        "No Winner"
      end
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << @player1.deck.remove_card
      @spoils_of_war << @player2.deck.remove_card
    elsif type == :war
      @spoils_of_war << @player1.top_three_cards
      @spoils_of_war << @player2.top_three_cards
      @spoils_of_war.flatten!
      remove_top_three_cards(@player1)
      remove_top_three_cards(@player2)
    else
      remove_top_three_cards(@player1)
      remove_top_three_cards(@player2)
    end
  end

  def remove_top_three_cards(player)
    3.times {player.deck.remove_card}
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

  def gameplay
    until continue_game? == false
      if type == :basic
        pile_cards
        p "Turn #{@turn_count}: #{winner} won #{@spoils_of_war.length} cards"
        award_spoils(winner)
        continue_game?
      elsif type == :war
        pile_cards
        p "Turn #{@turn_count}: WAR - #{winner} won #{@spoils_of_war.length} cards"
        award_spoils(winner)
        continue_game?
      else
        pile_cards
        p "Turn #{@turn_count}: *mutually assured destruction* 6 cards removed from play"
        continue_game?
      end
      @turn_count += 1
    end

    if @turn_count >= 1000000
      p "---- DRAW ----"
    else
      game_winner
    end

  end

  def continue_game?
    if player1.amount_of_cards == 0 || player2.amount_of_cards == 0
      winner
      false
    elsif player1.amount_of_cards < 3 || player2.amount_of_cards < 3
      if type == :war || type == :mutually_assured_destruction
        winner
        false
      end
    elsif @turn_count >= 1000000
      false
    end
  end

  def game_winner
    p "*~*~*~* #{winner} has won the game! *~*~*~*"
  end

end
