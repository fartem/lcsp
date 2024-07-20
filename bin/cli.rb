# frozen_string_literal: true

require 'dry/cli'
require 'fileutils'
require 'rubygems'

# frozen_string_literal: true

module CLI
  # lcsp CLI
  module Commands
    extend Dry::CLI::Registry

    # This class represents a command for printing a solution.
    # It inherits from Dry::CLI::Command and is registered under the 'print' alias.
    class Print < ::Dry::CLI::Command
      # Description of the command.
      desc 'Prints solution'

      # Option definition for the GitHub user name.
      # Default value is an empty string.
      option :user,
             default: '',
             desc: 'GitHub user name'

      # Option definition for the GitHub repository with solutions.
      # Default value is an empty string.
      option :repo,
             default: '',
             desc: 'GitHub repository with solutions'

      # Option definition for the number of needed solution.
      # Default value is an empty string.
      option :number,
             default: '',
             desc: 'Number of needed solution'

      # The main method of the command.
      # It creates an instance of LCSP::LCSP and calls its start method with the provided options.
      #
      # @param options [Hash] The command-line options.
      # @option options [String] :user The GitHub user name.
      # @option options [String] :repo The GitHub repository with solutions.
      # @option options [String] :number The number of needed solution.
      #
      # @return [void]
      def call(options)
        ::LCSP::LCSP.new.start(
          options[:user],
          options[:repo],
          options[:number]
        )
      end
    end

    # This class represents a command for cleaning the local cache of LCSP.
    # It inherits from Dry::CLI::Command and is registered under the 'clean' alias.
    class Clean < ::Dry::CLI::Command
      # Description of the command.
      desc 'Clean lscp cache'

      # The main method of the command.
      # It removes all folders in the current directory that start with 'cache_'.
      #
      # @return [void]
      def call
        # Get all entries in the current directory.
        folders = ::Dir.entries('.').select { |entry| entry.include?('cache_') }

        # Iterate over the selected folders and remove them.
        folders.each { |folder| ::FileUtils.rm_rf(folder) }
      end
    end

    # This class represents a command for printing the version of LCSP.
    # It inherits from Dry::CLI::Command and is registered under the 'version' alias.
    class Version < ::Dry::CLI::Command
      # Description of the command.
      desc 'Prints using version of lcsp'

      # The main method of the command.
      # It retrieves the version of the lcsp gem from its gemspec file and prints it.
      #
      # @return [void]
      def call
        # Load the lcsp gem specification.
        spec = ::Gem::Specification.load('lcsp.gemspec')

        # Print the version of the lcsp gem.
        puts(spec.version)
      end
    end

    # This class represents a command for printing the author of LCSP.
    # It inherits from Dry::CLI::Command and is registered under the 'author' alias.
    class Author < ::Dry::CLI::Command
      # Description of the command.
      desc 'Prints the author of lcsp'

      # The main method of the command.
      # It retrieves the author, email, and homepage information of the lcsp gem from its gemspec file and prints it.
      #
      # @return [void]
      def call
        # Load the lcsp gem specification.
        spec = ::Gem::Specification.load('lcsp.gemspec')

        # Print the author(s) of the lcsp gem.
        puts("Authors: #{spec.authors.join(', ').strip}")

        # Print the email(s) of the lcsp gem author(s).
        puts("Email: #{spec.email}")

        # Print the homepage of the lcsp gem.
        puts("Homepage: #{spec.homepage}")
      end
    end

    register 'print', Print.new, aliases: ['p']
    register 'clean', Clean.new, aliases: ['c']
    register 'version', Version.new, aliases: ['v']
    register 'author', Author.new, aliases: ['a']
  end
end

::Dry::CLI.new(::CLI::Commands).call
