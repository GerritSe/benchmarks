require "stringio"

out = StringIO.new

$stdout.define_singleton_method(:write) do |string|
  super(string)
  out << string
end

at_exit do
  out.rewind
  output = out.read

  return if output.empty?

  filename = [File.basename($0, ".rb"), "result.txt"].join("_")
  File.write(filename, output)
end
