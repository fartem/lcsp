# frozen_string_literal: true

require 'faraday'
require 'git'

module LCSP
  # Cache that applies a Language
  # and download solutions from GitHub
  # if repository exists.
  class LCSPCache
    # @param {String} user
    # @param {String} lang
    def initialize(user, lang)
      @user = user
      @lang = lang

      return if exists?

      ::Git.clone(
        URI("https://github.com/#{@user}/leetcode-#{@lang.downcase}"),
        "#{@user}-leetcode-#{@lang.downcase}"
      )
    end

    # Path of cache for @lang
    # @return {String}
    def path
      "#{::Dir.pwd}/#{@user}-leetcode-#{@lang.downcase}"
    end

    private

    # Check cache existing.
    # Recommend to run it before
    # all other operations.
    # @return {Boolean}
    def exists?
      ::File.exist?("#{::Dir.pwd}/#{@user}-leetcode-#{@lang.downcase}")
    end
  end
end
