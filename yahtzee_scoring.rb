class YahtzeeScoring
  def self.best_score(roll)
    frequencies = roll.tally
    sum = roll.sum

    # Yahtzee
    if frequencies.keys.length == 1
      return { category: :yahtzee, score: 50 }
    end

    # Large straight
    sorted_keys = frequencies.keys.sort
    if sorted_keys == [1, 2, 3, 4, 5] || sorted_keys == [2, 3, 4, 5, 6]
      return { category: :large_straight, score: 40 }
    end

    # Small straight
    straights = [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]]
    if straights.any? { |straight| straight.all? { |num| frequencies.key?(num) } }
      return { category: :small_straight, score: 30 }
    end

    # Full house
    if frequencies.values.sort == [2, 3]
      return { category: :full_house, score: 25 }
    end

    # Four of a kind
    if frequencies.values.include?(4)
      return { category: :four_of_a_kind, score: sum }
    end

    # Three of a kind
    if frequencies.values.include?(3)
      return { category: :three_of_a_kind, score: sum }
    end

    # If no other category matches, score as chance
    { category: :chance, score: sum }
  end
end
