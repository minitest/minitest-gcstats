require "minitest"

module Minitest::GCStats
  VERSION = "1.3.0"

  attr_accessor :gc_stats

  HASH = {}

  begin
    if GC.stat[:total_allocated_objects] then # ruby 2.2
      def self.current
        GC.stat :total_allocated_objects
      end
    else                                      # ruby 2.1
      GC.stat :total_allocated_object         # force raise
      def self.current
        GC.stat :total_allocated_object
      end
    end
  rescue TypeError
    def self.current                          # ruby 2.0
      GC.stat(HASH)[:total_allocated_object]
    end
  end

  def run
    r = super
    r.gc_stats = self.gc_stats
    r
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

module Minitest::GCStats::Result
  attr_accessor :gc_stats

  def self.prepended klass
    klass.singleton_class.prepend ClassMethods
  end

  module ClassMethods
    def from runnable
      r = super
      r.gc_stats = runnable.gc_stats
      r
    end
  end
end

Minitest::Test.prepend Minitest::GCStats
Minitest::Result.prepend Minitest::GCStats::Result

module Minitest::Assertions
  ##
  # Assert that the number of object allocations during block
  # execution is what you think it is. Uses +assert_operator+ so +op+
  # should be something like :== or :<=. Defaults to :==.
  #
  #   assert_allocations 3 do ... end
  #
  # is equivalent to:
  #
  #   assert_allocations :==, 3 do ... end

  def assert_allocations op_or_exp, exp = nil, msg = nil
    m0 = Minitest::GCStats.current
    yield
    m1 = Minitest::GCStats.current

    op = op_or_exp
    op, exp, msg = :==, op, exp if Integer === op

    act = m1 - m0
    msg ||= "Object allocations"

    assert_operator act, op, exp, msg
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
