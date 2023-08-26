#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative '../lib/lcsp'
require_relative 'lcsp_runner'

::LCSP::LCSPRunner.new(::ARGV).run
