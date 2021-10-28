require "minitest"

module Minitest
  @gcstats = false

  def self.plugin_gcstats_options opts, options # :nodoc:
    opts.on "-g", "--gcstats [N]", Integer, "Display top-N GC statistics per test." do |n|
      @gcstats = Integer(n||10)
    end
  end

  def self.plugin_gcstats_init options # :nodoc:
    if @gcstats then
      require "minitest/gcstats"
      self.reporter << Minitest::GCStatsReporter.new(@gcstats)
    end
  end
end
