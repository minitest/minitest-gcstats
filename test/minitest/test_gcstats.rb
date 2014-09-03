require "minitest/autorun"

module TestMinitest; end

class TestMinitest::TestGcstats < Minitest::Test
  def test_empty
    # 0 objects
  end

  def test_full
    Object.new          # 1 object
  end

  def test_assert
    assert :woot
  end

  def test_assert_bad
    assert nil
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_empty
    assert_empty []
  end

  def test_assert_empty_bad
    assert_empty [42]
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_equal
    assert_equal :a, :a
  end

  def test_assert_equal_bad
    assert_equal :a, :b
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_in_delta
    assert_in_delta 1.0, 1.0001
  end

  def test_assert_in_delta_bad
    assert_in_delta 1.0, 1.1
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_in_epsilon
    assert_in_epsilon 1.0, 1.001
  end

  def test_assert_in_epsilon_bad
    assert_in_epsilon 1.0, 1.1
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_includes
    assert_includes [:a, :woot, :c], :woot
  end

  def test_assert_includes_bad
    assert_includes [:a, :woot, :c], :b
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_instance_of
    assert_instance_of Symbol, :woot
  end

  def test_assert_instance_of_bad
    assert_instance_of Array, :woot
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_kind_of
    assert_kind_of Symbol, :woot
  end

  def test_assert_kind_of_bad
    assert_kind_of Array, :woot
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_match
    assert_match(/woot/, "woot")
  end

  def test_assert_match_bad
    assert_match(/woot/, "blah")
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_nil
    assert_nil nil
  end

  def test_assert_nil_bad
    assert_nil true
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_operator
    assert_operator [:a], :include?, :a
  end

  def test_assert_operator_bad
    assert_operator [:b], :include?, :a
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_output
    assert_output "woot\n" do
      puts "woot"
    end
  end

  def test_assert_output_bad
    assert_output "woot" do
      # do nothing
    end
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_predicate
    assert_predicate "", :empty?
  end

  def test_assert_predicate_bad
    assert_predicate "woot", :empty?
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_raises
    assert_raises RuntimeError do
      raise "woot"
    end
  end

  def test_assert_raises_bad
    assert_raises RuntimeError do
      # do nothing
    end
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_respond_to
    assert_respond_to :a, :empty?
  end

  def test_assert_respond_to_bad
    assert_respond_to :a, :full?
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_same
    assert_same :a, :a
  end

  def test_assert_same_bad
    assert_same :a, :b
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_silent
    assert_silent do
      # do nothing
    end
  end

  def test_assert_silent_bad
    assert_silent do
      puts "woot"
    end
  rescue Minitest::Assertion
    # do nothing
  end

  def test_assert_throws
    assert_throws :woot do
      throw :woot
    end
  end

  def test_assert_throws_bad
    assert_throws :woot do
      # do nothing
    end
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute
    refute false
  end

  def test_refute_bad
    refute true
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_empty
    refute_empty [:a]
  end

  def test_refute_empty_bad
    refute_empty []
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_equal
    refute_equal :a, :b
  end

  def test_refute_equal_bad
    refute_equal :a, :a
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_in_delta
    refute_in_delta 1.0, 1.1
  end

  def test_refute_in_delta_bad
    refute_in_delta 1.0, 1.0001
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_in_epsilon
    refute_in_epsilon 1.0, 1.1
  end

  def test_refute_in_epsilon_bad
    refute_in_epsilon 1.0, 1.001
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_includes
    refute_includes [:a, :woot, :c], :b
  end

  def test_refute_includes_bad
    refute_includes [:a, :woot, :c], :woot
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_instance_of
    refute_instance_of Array, :a
  end

  def test_refute_instance_of_bad
    refute_instance_of Symbol, :a
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_kind_of
    refute_kind_of Array, :woot
  end

  def test_refute_kind_of_bad
    refute_kind_of Symbol, :woot
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_match
    refute_match(/woot/, "blah")
  end

  def test_refute_match_bad
    refute_match(/woot/, "woot")
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_nil
    refute_nil true
  end

  def test_refute_nil_bad
    refute_nil nil
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_operator
    refute_operator [:b], :include?, :a
  end

  def test_refute_operator_bad
    assert_operator [:a], :include?, :a
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_predicate
    refute_predicate "woot", :empty?
  end

  def test_refute_predicate_bad
    refute_predicate "", :empty?
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_respond_to
    refute_respond_to :a, :full?
  end

  def test_refute_respond_to_bad
    refute_respond_to :a, :empty?
  rescue Minitest::Assertion
    # do nothing
  end

  def test_refute_same
    refute_same :a, :b
  end

  def test_refute_same_bad
    refute_same :a, :a
  rescue Minitest::Assertion
    # do nothing
  end
end
