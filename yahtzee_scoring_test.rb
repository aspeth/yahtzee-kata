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

  # Test that the best scoring category is always selected when a roll matches multiple categories
  def test_best_scoring_category_is_selected
    # Yahtzee beats three or four of a kind
    assert_equal({ category: :yahtzee, score: 50 }, YahtzeeScoring.best_score([5, 5, 5, 5, 5]))

    # Large straight beats small straight
    assert_equal({ category: :large_straight, score: 40 }, YahtzeeScoring.best_score([1, 2, 3, 4, 5]))

    # Full house beats three of a kind
    assert_equal({ category: :full_house, score: 25 }, YahtzeeScoring.best_score([2, 2, 4, 4, 4]))
  end
end
