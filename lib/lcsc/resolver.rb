# frozen_string_literal: true

require_relative '../common/cache'

module LCSC
  # LCSCResolver logic.
  class LCSCResolver
    # LCSCResolver is entry point for any LCSP request by user.
    #
    # @param user [String] The GitHub username of the user.
    # @param repository [String] The name of the repository containing the LCSP problem.
    def initialize(user, repository)
      @user = user
      @repository = repository
    end

    # Resolves the LCSC by creating an LCSPCache instance, locating the LCSCCounter file,
    # requiring it, and then creating an LCSCCounter instance to find the solution.
    #
    # @return [String] The solution to the LCSP problem.
    # @return [nil] If the LCSPFinder file is not found or the solution is not found.
    def resolve
      cache = ::LCSP::LCSPCache.new(@user, @repository)
      finder_path = "#{cache.path}/lcsp/counter.rb"

      unless ::File.exist?(finder_path)
        puts('counter.rb not found in repository. Please, check config and try again.')

        exit(1)
      end

      require_relative(finder_path)

      count = ::LCSC::LCSCCounter.new(cache.path).count

      if count.nil?
        puts('Failed to count solutions. Please, check your input and try again.')

        exit(2)
      end

      count
    end
  end
end
