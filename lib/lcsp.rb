# frozen_string_literal: true

require 'rouge'
require 'rouge/cli'

require_relative './lcsp/resolver'

module LCSP
  # LCSP starter.
  class LCSP
    # Start tool for searching solution.
    # Language can be applied in any case.
    # @param {String} user
    # @param {String} lang
    # @param {String} number
    def start(user, lang, number)
      output = ::LCSP::LCSPResolver.new(user, lang, number).resolve
      ::Rouge::CLI.parse([output]).run
    end
  end
end
