require "benchmark/ips"
require_relative "lib/capture_stdout"
require_relative "lib/system_info"

SystemInfo.print

Benchmark.ips do |bm|
  bm.time = 10

  bm.report("proc_keyword") do
    proc {}.call
  end

  bm.report("proc_constructor") do
    Proc.new {}.call
  end

  bm.report("lambda") do
    lambda {}.call
  end

  bm.report("lambda_literal") do
    -> {}.call
  end

  bm.compare!
end
