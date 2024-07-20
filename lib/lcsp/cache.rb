# frozen_string_literal: true

require 'faraday'
require 'git'

module LCSP
  # Base LCSP cache
  class LCSPCache
    # This class is responsible for managing a local cache of a specified GitHub repository.
    # It clones the repository if it does not already exist in the cache directory.

    # Initializes a new instance of LCSPCache.
    #
    # @param user [String] The GitHub username of the repository owner.
    # @param repository [String] The name of the repository.
    def initialize(user, repository)
      @user = user
      @repository = repository

      return if exists?

      ::Git.clone(
        URI("https://github.com/#{@user}/#{@repository.downcase}"),
        ::Pathname.new("cache_#{@user}-#{@repository.downcase}")
      )
    end

    # Returns the path to the local cache directory for the specified repository.
    #
    # @return [String] The path to the local cache directory.
    def path
      "#{::Dir.pwd}/cache_#{@user}-#{@repository.downcase}"
    end

    private

    # Checks if the local cache directory for the specified repository already exists.
    #
    # @return [Boolean] True if the directory exists, false otherwise.
    def exists?
      ::File.exist?("#{::Dir.pwd}/cache_#{@user}-#{@repository.downcase}")
    end
  end
end
