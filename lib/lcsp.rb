require 'rouge'
require 'rouge/cli'

require_relative './lcsp/resolver'

module LCSP
  class LCSP
    def start(lang, number)
      output = LCSPResolver.new(lang, number).resolve
      Rouge::CLI.parse([output]).run
    end
  end
end
