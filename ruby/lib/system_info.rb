class SystemInfo
  def self.print
    puts "Machine:"
    puts ""
    puts %x{sysctl -a | grep machdep.cpu. | sed "s/machdep.cpu.//"}
    puts ""
    puts "Ruby version: #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
    puts ""
  end
end
