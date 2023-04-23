require_relative './cache'
require_relative './finder'

module LCSP
  class LCSPResolver
    def initialize(lang, number)
      @lang = lang
      @number = number
    end

    def resolve
      cache = LCSPCache.new(@lang)
      cache.create unless cache.exists?
      LCSPFinder.new(cache.path, @number).solution
    end
  end
end
