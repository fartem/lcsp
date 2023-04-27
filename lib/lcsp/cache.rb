require 'faraday'
require 'git'

module LCSP
  # Cache that applies a Language
  # and download solutions from GitHub
  # if repository exists.
  class LCSPCache
    # @param lang {String}
    def initialize(lang)
      @lang = lang
    end

    # Check cache existing.
    # Recommend to run it before
    # all other operations.
    def exists?
      ::File.exist?("#{::Dir.pwd}/leetcode-#{@lang.downcase}")
    end

    # @todo extract to separated class (like CacheResolver or something similar)
    def create
      ::Git.clone(URI("https://github.com/fartem/leetcode-#{@lang.downcase}"))
    end

    # Path of cache for @lang
    def path
      "#{::Dir.pwd}/leetcode-#{@lang.downcase}"
    end
  end
end
