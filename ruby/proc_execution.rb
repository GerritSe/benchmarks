require "benchmark/ips"
require_relative "lib/capture_stdout"
require_relative "lib/system_info"

SystemInfo.print

PROC_KEYWORD = proc {}
PROC_CONSTRUCTOR = Proc.new {}
LAMBDA = lambda {}
LAMBDA_LITERAL = -> {}

Benchmark.ips do |bm|
  bm.time = 10

  bm.report("proc_keyword") do
    PROC_KEYWORD.call
  end

  bm.report("proc_constructor") do
    PROC_CONSTRUCTOR.call
  end

  bm.report("lambda") do
    LAMBDA.call
  end

  bm.report("lambda_literal") do
    LAMBDA_LITERAL.call
  end

  bm.compare!
end
