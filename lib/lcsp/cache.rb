require 'faraday'
require 'git'

module LCSP
  class LCSPCache
    def initialize(lang)
      @lang = lang
    end

    def exists?
      File.exist? "#{Dir.pwd}/leetcode-#{@lang.downcase}"
    end

    # @todo extract to separated class (like CacheResolver or something similar)
    def create
      Git.clone("https://github.com/fartem/leetcode-#{@lang.downcase}")
    end

    def path
      "#{Dir.pwd}/leetcode-#{@lang.downcase}"
    end
  end
end
