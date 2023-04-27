require_relative './cache'
require_relative './finder'

module LCSP
  # Class that resolve request by user
  class LCSPResolver
    # Resolver needs Language name in any case
    # and number of LeetCode problem that user
    # tries to find.
    # @param lang {String}
    # @param number {String}
    def initialize(lang, number)
      @lang = lang
      @number = number
    end

    # Main LCSPResolver method that applies
    # cache and find solution.
    def resolve
      cache = LCSPCache.new(@lang)
      cache.create unless cache.exists?
      LCSPFinder.new(cache.path, @number).solution
    end
  end
end
