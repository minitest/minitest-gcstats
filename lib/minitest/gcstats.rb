require "minitest"

module Minitest::GCStats
  VERSION = "1.0.0"

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

class Minitest::GCStatsReporter < Minitest::AbstractReporter
  attr_accessor :stats, :max

  def initialize max
    super()

    self.max = max
    self.stats = {}
  end

  def record result
    self.stats["#{result.class.name}##{result.name}"] = result.gc_stats
  end

  def report
    puts
    puts "Top #{max} tests by objects allocated"
    puts
    stats.sort_by { |k,v| [-v, k] }.first(max).each do |k,v|
      puts "%6d: %s" % [v, k]
    end
    puts
  end
end
