require 'rouge'
require 'rouge/cli'

require_relative './lcsp/resolver'

module LCSP
  # LCSP starter.
  class LCSP
    # Start tool for searching solution.
    # Language can be applied in any case.
    # @param lang {String}
    # @param number {String}
    def start(lang, number)
      output = ::LCSPResolver.new(lang, number).resolve
      ::Rouge::CLI.parse([output]).run
    end
  end
end
