require 'shellwords'

# Help run methods from the commandline
class Runner
  def self.run(command, options)
    `#{command} #{options.join(' ')}`
  end
end
