require "minitest/autorun"
require "minitest/gcstats"
require "minitest/proveit"

module TestMinitest; end

class TestMinitest::TestGcstats < Minitest::Test
  self.prove_it = false

  def util_n_times_full n
    n.times { test_full }
  end

  def util_array
    [test_full]
  end

  def setup
    util_n_times_full 1 # warm

    assert_allocations :<, 99 do
       # warm it up
    end
  end

  def test_empty
    # 0 objects
  end

  def test_full
    Object.new          # 1 object
  end

  def test_assert_allocations
    assert_allocations 1 do
      test_full
    end
  end

  def test_assert_allocations_0
    assert_allocations 0 do
      # nothing
    end
  end

  def test_assert_allocations_multi
    assert_allocations 3 do
      util_n_times_full 3
    end
  end

  def test_assert_allocations_multi_eq
    assert_allocations :==, 3 do
      util_n_times_full 3
    end
  end

  def test_assert_allocations_neg_lt
    assert_allocations :<=, 3 do
      util_n_times_full 2
    end
  end

  def test_assert_allocations_neg_eq
    assert_allocations :<=, 3 do
      util_n_times_full 3
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

    util_array # warm

    assert_triggered exp do
      assert_allocations 1 do
        util_array
      end
    end
  end

  def test_assert_allocations_neg_bad
    util_n_times_full 5

    exp = "Object allocations.\nExpected #{5} to be <= 3."

    assert_triggered exp do
      assert_allocations :<=, 3 do
        util_n_times_full 5
      end
    end
  end
end
