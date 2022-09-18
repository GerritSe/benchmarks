require "stringio"

out = StringIO.new
interrupted = false

$stdout.define_singleton_method(:write) do |string|
  super(string)
  out << string
end

Signal.trap("INT") do
  interrupted = true
  exit
end

at_exit do |x|
  next if interrupted

  out.rewind
  output = out.read

  next if output.empty?

  filename = [File.basename($0, ".rb"), "result.txt"].join("_")
  File.write(filename, output)
end
