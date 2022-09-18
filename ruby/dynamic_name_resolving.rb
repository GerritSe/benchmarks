require "benchmark/ips"
require_relative "lib/capture_stdout"
require_relative "lib/system_info"

SystemInfo.print

NAMES = ["First", "Second", "Third"] * 3

class FirstClass
  def some_method; end
end

class SecondClass
  def some_method; end
end

class ThirdClass
  def some_method; end
end

Benchmark.ips do |bm|
  bm.time = 10

  bm.report("case_statement") do
    NAMES.each do |name|
      case name
      when "First" then FirstClass.new.some_method
      when "Second" then SecondClass.new.some_method
      when "Third" then ThirdClass.new.some_method
      end
    end
  end

  bm.report("case_statement_with_symbols") do
    NAMES.each do |name|
      case name.to_sym
      when :First then FirstClass.new.some_method
      when :Second then SecondClass.new.some_method
      when :Third then ThirdClass.new.some_method
      end
    end
  end

  bm.report("dynamic_name_resolve") do
    NAMES.each do |name|
      Object.const_get("#{name}Class").new.some_method
    end
  end

  bm.compare!
end
