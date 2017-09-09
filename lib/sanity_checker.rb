require 'colorize'

# Help checking if needed dependencies are available, and suggest ways to
# install them if not
class SanityChecker
  # Make sure the needed dependencies are available. If not, will stop the
  # script and prompt to install them
  def self.dependency(command)
    return if installed?(command)
    puts "✘ #{command} is not installed".yellow
    abort("Please, install #{command} before running this conversion".red)
  end

  # Check if specified command is installed
  def self.installed?(command)
    !which(command).empty?
  end

  # Equivalent of the command-line `which` command
  def self.which(command)
    `which #{command}`.strip
  end

  # Make sure all inputs are of the correct extensions. Will stop if not input
  # of valid
  def self.extension(extension, raw_inputs)
    inputs = []
    raw_inputs.each do |input|
      input = File.expand_path(input)
      input_extension = File.extname(input)
      unless input_extension[/^\.#{extension}$/i]
        puts "⚠ #{input} is not a .#{extension} file"
        next
      end
      unless File.exist(input)
        puts "⚠ Can't find #{input} file"
        next
      end
      input << inputs
    end

    abort('No input specified'.red) if inputs.empty?

    inputs
  end
end
