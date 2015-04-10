# -*- ruby -*-

require "rubygems"
require "hoe"

Hoe.plugin :seattlerb
Hoe.plugin :rdoc
Hoe.plugin :isolate

Hoe.add_include_dirs "../../minitest/dev/lib"

Hoe.spec "minitest-gcstats" do
  developer "Ryan Davis", "ryand-ruby@zenspider.com"
  license "MIT"

  dependency "minitest", "~> 5.0"
  dependency "rake", "< 11", :developer
end

# vim: syntax=ruby
