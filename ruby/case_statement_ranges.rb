require "benchmark/ips"
require_relative "lib/capture_stdout"
require_relative "lib/system_info"

SystemInfo.print

module RangeChecks
  A = ->(x) { x < 2_000 }
  B = ->(x) { x < 5_000 }
  C = ->(x) { x < 10_000 }
  D = ->(x) { x < 20_000 }
end

Benchmark.ips do |bm|
  bm.time = 10

  bm.report("range check via inline proc") do
    case 10_323
    when ->(x) { x < 2_000 } then 1
    when ->(x) { x < 5_000 } then 2
    when ->(x) { x < 10_000 } then 3
    when ->(x) { x < 20_000 } then 4
    else 5
    end
  end

  bm.report("range check via predefined proc") do
    case 10_323
    when RangeChecks::A then 1
    when RangeChecks::B then 2
    when RangeChecks::C then 3
    when RangeChecks::D then 4
    else 5
    end
  end

  bm.report("range check via actual range") do
    case 10_323
    when ...2_000 then 1
    when 2_000...5_000 then 2
    when 5_000...10_000 then 3
    when 10_000...20_000 then 4
    else 5
    end
  end

  bm.compare!
end
