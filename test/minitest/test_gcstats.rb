require "minitest/autorun"
require "minitest/gcstats"
require "minitest/proveit"

module TestMinitest; end

class TestMinitest::TestGcstats < Minitest::Test
  self.prove_it = false

  def test_empty
    # 0 objects
  end

  def test_full
    Object.new          # 1 object
  end

  def test_assert_allocations
    assert_allocations 1 do
      []
    end
  end

  def test_assert_allocations_0
    assert_allocations 0 do
      # nothing
    end
  end

  def test_assert_allocations_multi
    assert_allocations 3 do
      3.times { Object.new }
    end
  end

  def test_assert_allocations_multi_eq
    assert_allocations :==, 3 do
      3.times { Object.new }
    end
  end

  def test_assert_allocations_neg_lt
    assert_allocations :<=, 3 do
      2.times { Object.new }
    end
  end

  def test_assert_allocations_neg_eq
    assert_allocations :<=, 3 do
      3.times { Object.new }
    end
  end

  def assert_triggered expected, klass = Minitest::Assertion
    e = assert_raises klass do
      yield
    end

    msg = e.message.sub(/(---Backtrace---).*/m, '\1')
    msg.gsub!(/\(oid=[-0-9]+\)/, "(oid=N)")
    msg.gsub!(/(\d\.\d{6})\d+/, '\1xxx') # normalize: ruby version, impl, platform

    assert_equal expected, msg
  end

  def test_assert_allocations_bad
    exp = "Object allocations.\nExpected 2 to be == 1."

    assert_triggered exp do
      assert_allocations 1 do
        [Object.new]
      end
    end
  end

  def test_assert_allocations_neg_bad
    exp = "Object allocations.\nExpected 5 to be <= 3."

    assert_triggered exp do
      assert_allocations :<=, 3 do
        5.times { Object.new }
      end
    end
  end
end
