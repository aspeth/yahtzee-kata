class YahtzeeScoring
  def self.best_score(roll)
    best_category = nil
    best_score = 0

    score = score_lower_section(roll)
    if score[:score] > best_score
      best_score = score[:score]
      best_category = score[:category]
    end

    { category: best_category, score: best_score }
  end

  def self.score_lower_section(roll)
    best_category = nil
    best_score = 0

    categories = [
      score_yahtzee(roll),
      score_large_straight(roll),
      score_small_straight(roll),
      score_full_house(roll),
      score_four_of_a_kind(roll),
      score_three_of_a_kind(roll),
      score_chance(roll)
    ]

    categories.each do |result|
      if result[:score] > best_score
        best_score = result[:score]
        best_category = result[:category]
      end
    end

    { category: best_category, score: best_score }
  end

  def self.score_three_of_a_kind(roll)
    roll.each do |num|
      return { category: :three_of_a_kind, score: roll.sum } if roll.count(num) >= 3
    end
    { category: nil, score: 0 }
  end

  def self.score_four_of_a_kind(roll)
    roll.each do |num|
      return { category: :four_of_a_kind, score: roll.sum } if roll.count(num) >= 4
    end
    { category: nil, score: 0 }
  end

  def self.score_full_house(roll)
    counts = roll.tally.values.sort
    return { category: :full_house, score: 25 } if counts == [2, 3]
    { category: nil, score: 0 }
  end

  def self.score_small_straight(roll)
    unique_sorted = roll.uniq.sort
    straights = [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]]
    return { category: :small_straight, score: 30 } if straights.any? { |s| (s - unique_sorted).empty? }
    { category: nil, score: 0 }
  end

  def self.score_large_straight(roll)
    unique_sorted = roll.uniq.sort
    return { category: :large_straight, score: 40 } if unique_sorted == [1, 2, 3, 4, 5] || unique_sorted == [2, 3, 4, 5, 6]
    { category: nil, score: 0 }
  end

  def self.score_yahtzee(roll)
    return { category: :yahtzee, score: 50 } if roll.uniq.length == 1
    { category: nil, score: 0 }
  end

  def self.score_chance(roll)
    { category: :chance, score: roll.sum }
  end
end
