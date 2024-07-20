# frozen_string_literal: true

require_relative './cache'

module LCSP
  # LCSPResolver logic
  class LCSPResolver
    # LCSPResolver is responsible for resolving the Least Common Subsequence Problem (LCSP)
    # for a given user, repository, and problem number.
    #
    # @param user [String] The GitHub username of the user.
    # @param repository [String] The name of the repository containing the LCSP problem.
    # @param number [Integer] The problem number for which the LCSP needs to be resolved.
    def initialize(user, repository, number)
      @user = user
      @repository = repository
      @number = number
    end

    # Resolves the LCSP by creating an LCSPCache instance, locating the LCSPFinder file,
    # requiring it, and then creating an LCSPFinder instance to find the solution.
    #
    # @return [String] The solution to the LCSP problem.
    # @return [nil] If the LCSPFinder file is not found or the solution is not found.
    def resolve
      cache = ::LCSP::LCSPCache.new(@user, @repository)
      finder_path = "#{cache.path}/lcsp/finder.rb"

      unless ::File.exist?(finder_path)
        puts('finder.rb not found in repository. Please, check config and try again.')

        exit(1)
      end

      require_relative(finder_path)

      solution = ::LCSP::LCSPFinder.new(cache.path, @number).solution

      if solution.nil?
        puts('Solution not found. Please, check your input and try again.')

        exit(2)
      end

      solution
    end
  end
end
