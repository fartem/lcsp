# frozen_string_literal: true

require 'fileutils'

module LCSP
  # LCSP CLI runner
  class LCSPRunner
    # Initializes a new instance of LCSPRunner with the given arguments.
    #
    # @param args [Array<String>] The command-line arguments passed to the script.
    def initialize(args)
      @args = args
    end

    # Runs the LCSPRunner based on the provided command-line arguments.
    #
    # If no arguments are provided, the script exits with a status code of 1.
    #
    # If one argument is provided and it is 'clean', the script removes all folders
    # starting with 'cache_' in the current directory.
    #
    # If three arguments are provided, the script creates a new instance of LCSP and
    # calls its start method with the provided arguments.
    #
    # If the number of arguments is not 1 or 3, the script exits with a status code of 1.
    def run
      exit(1) if @args.empty?

      case @args.length
      when 1
        arg = @args.first
        exit(1) if arg != 'clean'

        folders = ::Dir.entries('.').select { |entry| entry.start_with?('cache_') }
        folders.each do |folder|
          ::FileUtils.rm_rf(folder)
        end
      when 3
        ::LCSP::LCSP.new.start(@args[0], @args[1], @args[2])
      else
        exit(1)
      end
    end
  end
end
