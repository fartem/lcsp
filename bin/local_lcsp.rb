#!/usr/bin/env ruby

require_relative '../lib/lcsp'

::LCSP::LCSP.new.start(::ARGV[0], ::ARGV[1])
