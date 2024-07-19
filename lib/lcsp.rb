# frozen_string_literal: true

require 'rouge'
require 'rouge/cli'

require_relative './lcsp/resolver'

module LCSP
  # This class represents the main functionality of the LCSP (Longest Common Subsequence Problem) tool.
  class LCSP
    # Starts the LCSP tool by resolving the longest common subsequence for a given user, repository,
    # and pull request number.
    #
    # @param user [String] The GitHub username of the repository owner.
    # @param repository [String] The name of the GitHub repository.
    # @param number [Integer] The pull request number.
    #
    # @return [Integer] The exit status of the Rouge CLI tool after processing the resolved LCSP.
    def start(user, repository, number)
      output = ::LCSP::LCSPResolver.new(user, repository, number).resolve
      ::Rouge::CLI.parse([output]).run
    end
  end
end
