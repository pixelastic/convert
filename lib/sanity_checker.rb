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
  def self.extension(extensions, raw_inputs)
    inputs = []
    extensions = [extensions] unless extensions.is_a?(Array)

    raw_inputs.each do |input|
      input = File.expand_path(input)
      input_extension = File.extname(input)
      basename = File.basename(input)

      # File exists
      unless File.exist?(input)
        puts "⚠ Can't find #{input} file".yellow
        next
      end

      # File is from a valid extensions
      is_valid_extension = false
      extensions.each do |extension|
        if input_extension[/^\.#{extension}$/i]
          is_valid_extension = true
          break
        end
      end
      unless is_valid_extension
        puts "⚠ \"#{basename}\" is not a .#{extension} file".yellow
        next
      end

      # Everything ok, we can process it
      inputs << input
    end

    abort('No input specified'.red) if inputs.empty?

    inputs.uniq.sort
  end
end
