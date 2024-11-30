# frozen_string_literal: true

require 'rouge'
require 'rouge/cli'

require_relative './lcsc/resolver'

module LCSC
  # This class represents the main functionality of the LCSC (LeetCode Solution Counter) tool.
  class LCSC
    # Starts the LCSC tool.
    #
    # @param user [String] The GitHub username of the repository owner.
    # @param repository [String] The name of the GitHub repository.
    #
    # @return [Integer] The exit status of the Rouge CLI tool after processing the resolved LCSP.
    def start(user, repository)
      output = ::LCSC::LCSCResolver.new(user, repository).resolve

      ::Rouge::CLI.parse([output]).run
    end
  end
end
