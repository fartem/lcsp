# frozen_string_literal: true

require_relative './cache'

module LCSP
  # Class that resolve request by user
  class LCSPResolver
    # Resolver needs Language name in any case
    # and number of LeetCode problem that user
    # tries to find.
    # @param {String} user
    # @param {String} lang
    # @param {String} number
    def initialize(user, lang, number)
      @user = user
      @lang = lang
      @number = number
    end

    # Main LCSPResolver method that applies
    # cache and find solution.
    # @return {String}
    def resolve
      cache = ::LCSP::LCSPCache.new(@user, @lang)
      finder_path = "#{cache.path}/lcsp/finder.rb"

      exit(1) unless ::File.exist?(finder_path)

      require_relative(finder_path)

      solution = ::LCSP::LCSPFinder.new(cache.path, @number).solution

      exit(1) if solution.nil?

      solution
    end
  end
end
