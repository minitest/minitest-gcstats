require "minitest"

module Minitest::GCStats
  VERSION = "1.1.0"

  attr_accessor :gc_stats

  HASH = {}

  begin
    GC.stat :total_allocated_object

    def self.current
      GC.stat :total_allocated_object
    end
  rescue TypeError
    def self.current
      GC.stat(HASH)[:total_allocated_object]
    end
  end

  def before_setup
    super
    self.gc_stats = -Minitest::GCStats.current
  end

  def after_teardown
    self.gc_stats += Minitest::GCStats.current
    super
  end
end

module Minitest::Assertions
  ##
  # Assert the number of object allocations during block execution. If
  # +exp+ is positive, the number of allocations must be equal to that
  # value. If +exp+ is negative, the number of objects must be <=
  # +exp.abs+.

  def assert_allocations exp, msg = nil
    m0 = Minitest::GCStats.current
    yield
    m1 = Minitest::GCStats.current

    act = m1 - m0
    op  = exp >= 0 ? :== : :<=
    exp = -exp if exp < 0
    msg ||= "Object allocations"

    assert_operator act, op, exp.abs, msg
  end
end

class Minitest::GCStatsReporter < Minitest::AbstractReporter
  attr_accessor :stats, :max

  def initialize max
    super()

    self.max = max
    self.stats = {}
  end

  def record result
    self.stats[result] = result.gc_stats
  end

  def report
    total = stats.values.inject(&:+)
    pct = total / 100.0

    puts
    puts "Top #{max} tests by objects allocated"
    puts
    stats.sort_by { |k,v| [-v, k.class.name, k.name] }.first(max).each do |k,v|
      puts "%6d (%5.2f%%): %s" % [v, v / pct, k]
    end
    puts

    puts "%6d: %s" % [total, "Total"]
  end
end
