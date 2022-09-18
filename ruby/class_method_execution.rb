require "benchmark/ips"
require_relative "lib/capture_stdout"
require_relative "lib/system_info"

SystemInfo.print

class Regular
  def self.some_method; end
end

class ClassEval
  class_eval <<~RUBY
    def self.some_method; end
  RUBY
end

class ClassExec
  class_exec do
    def self.some_method; end
  end
end

class Eigenclass
  class << self
    def some_method; end
  end
end

class DefineSingletonMethod
  define_singleton_method("some_method") {}
end

Benchmark.ips do |bm|
  bm.time = 10

  bm.report("regular") do
    Regular.some_method
  end

  bm.report("class_eval") do
    ClassEval.some_method
  end

  bm.report("class_exec") do
    ClassExec.some_method
  end

  bm.report("eigenclass") do
    Eigenclass.some_method
  end

  bm.report("define_singleton_method") do
    DefineSingletonMethod.some_method
  end

  bm.compare!
end
