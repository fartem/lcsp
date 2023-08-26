# frozen_string_literal: true

require 'fileutils'

module LCSP
  # LCSP Runner
  class LCSPRunner
    # @param {String[]} args
    def initialize(args)
      @args = args
    end

    # LCSP Runner entry point
    def run
      exit(1) if @args.empty?

      case @args.length
      when 1
        arg = @args.first
        exit(1) if arg != 'clean'

        folders = ::Dir.entries('.').select { |entry| entry.include?('-leetcode-') }
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
