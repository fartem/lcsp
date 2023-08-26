#!/usr/bin/env ruby

# frozen_string_literal: true

require 'lcsp'

require_relative 'lcsp_runner'

::LCSP::LCSPRunner.new(::ARGV).run
