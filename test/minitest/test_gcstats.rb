require "minitest/autorun"
require "minitest/gcstats"

module TestMinitest; end

class TestMinitest::TestGcstats < Minitest::Test
  def test_empty
    # do nothing
  end

  def test_full
    Object.new
  end
end
