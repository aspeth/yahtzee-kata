require "minitest/autorun"
require_relative "yahtzee_scoring"

class TestYahtzeeScoring < Minitest::Test
  # Original test to make sure no regressions are introduced
  def test_best_score
    assert_equal({ category: :yahtzee, score: 50 }, YahtzeeScoring.best_score([6, 6, 6, 6, 6]))
    assert_equal({ category: :large_straight, score: 40 }, YahtzeeScoring.best_score([2, 3, 4, 5, 6]))
    assert_equal({ category: :three_of_a_kind, score: 21 }, YahtzeeScoring.best_score([6, 6, 6, 2, 1]))
    assert_equal({ category: :full_house, score: 25 }, YahtzeeScoring.best_score([3, 3, 3, 5, 5]))
    assert_equal({ category: :chance, score: 17 }, YahtzeeScoring.best_score([1, 2, 3, 5, 6]))
  end

  # == Lower Section Tests ==
  def test_three_of_a_kind
    assert_equal({ category: :three_of_a_kind, score: 21 }, YahtzeeScoring.best_score([6, 6, 6, 2, 1]))
  end

  def test_four_of_a_kind
    assert_equal({ category: :four_of_a_kind, score: 21 }, YahtzeeScoring.best_score([5, 5, 5, 5, 1]))
  end

  def test_full_house
    assert_equal({ category: :full_house, score: 25 }, YahtzeeScoring.best_score([3, 3, 3, 5, 5]))
  end

  def test_small_straight
    assert_equal({ category: :small_straight, score: 30 }, YahtzeeScoring.best_score([1, 2, 3, 4, 6]))
    assert_equal({ category: :small_straight, score: 30 }, YahtzeeScoring.best_score([2, 3, 4, 5, 5]))
    assert_equal({ category: :small_straight, score: 30 }, YahtzeeScoring.best_score([3, 3, 4, 5, 6]))
  end

  def test_large_straight
    assert_equal({ category: :large_straight, score: 40 }, YahtzeeScoring.best_score([2, 3, 4, 5, 6]))
    assert_equal({ category: :large_straight, score: 40 }, YahtzeeScoring.best_score([1, 2, 3, 4, 5]))
  end

  def test_yahtzee
    assert_equal({ category: :yahtzee, score: 50 }, YahtzeeScoring.best_score([6, 6, 6, 6, 6]))
    assert_equal({ category: :yahtzee, score: 50 }, YahtzeeScoring.best_score([1, 1, 1, 1, 1]))
  end

  def test_chance
    assert_equal({ category: :chance, score: 17 }, YahtzeeScoring.best_score([1, 2, 3, 5, 6]))
  end

  # Test that the best scoring category is always selected
  def test_best_scoring_category_is_selected
    # Yahtzee beats everything
    assert_equal({ category: :yahtzee, score: 50 }, YahtzeeScoring.best_score([5, 5, 5, 5, 5]))

    # Large straight beats small straight
    assert_equal({ category: :large_straight, score: 40 }, YahtzeeScoring.best_score([1, 2, 3, 4, 5]))

    # Full house beats three of a kind
    assert_equal({ category: :full_house, score: 25 }, YahtzeeScoring.best_score([2, 2, 4, 4, 4]))
  end

  # I tried to write scenarios for each category but if we always return the highest scoring category,
  # we never actually return anything from the upper section. In all these examples, `chance`
  # is a higher scoring category because it includes all dice and not just the matching numbers.
  # If I added another matching number to any example, `three_of_a_kind` would be the highest scoring category.

  # This is an area where we could extend the funcitionality to allow the user to choose from any available category
  # that matches the current roll. This aligns more with real-life Yahtzee play but is out of scope for this exercise.

  # == Upper Section Tests ==
  # def test_ones
  #   assert_equal({ category: :ones, score: 2 }, YahtzeeScoring.best_score([1, 1, 2, 3, 5]))
  # end

  # def test_twos
  #   assert_equal({ category: :twos, score: 4 }, YahtzeeScoring.best_score([2, 2, 5, 1, 3]))
  # end

  # def test_threes
  #   assert_equal({ category: :threes, score: 6 }, YahtzeeScoring.best_score([3, 3, 5, 1, 2]))
  # end

  # def test_fours
  #   assert_equal({ category: :fours, score: 8 }, YahtzeeScoring.best_score([4, 4, 5, 1, 2]))
  # end

  # def test_fives
  #   assert_equal({ category: :fives, score: 10 }, YahtzeeScoring.best_score([5, 5, 6, 1, 2]))
  # end

  # def test_sixes
  #   assert_equal({ category: :sixes, score: 12 }, YahtzeeScoring.best_score([6, 6, 5, 1, 2]))
  # end
end
