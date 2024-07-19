# lcsp

[![GitHubActions](https://github.com/fartem/distincter2/workflows/Build/badge.svg)](https://github.com/fartem/distincter2/actions?branch=master)
[![codebeat badge](https://codebeat.co/badges/eca07972-3b5a-4b3c-a424-a277ce8128b7)](https://codebeat.co/projects/github-com-fartem-lcsp-master)

## About

A tool for showing solutions from LeetCode.

## How to use

### Installation

Soon.

### Run

You need to provide 3 arguments for run `lcsp`:

| Parameter number | Description       | Example         |
|------------------|-------------------|-----------------|
| 1                | GitHub user name  | `fartem`        |
| 2                | Repository name   | `leetcode-ruby` |
| 3                | Number of problem | `11`            |

One of valid input variants be like:

```shell
$ lcsp fartem leetcode-ruby 11
```

### How to write your own `LCSPResolver`

#### Read before start

`lcsp` works with custom resolvers - classes that should placed in your project and that will perform
search locally.

You need to write resolver classes in Ruby because only this format accepting right now, but all work
around search and parse for your repository you can place in classes/scripts/files in any other programming language.

One of the correct and working example available
by [this link](https://github.com/fartem/leetcode-ruby/blob/master/lcsp/finder.rb).

#### Template class

`path` and `number` are default parameters that are presenting for every repository. This arguments describes user needs
and gives you parameters to search.

```ruby
# frozen_string_literal: true

module LCSP
  # Solutions finder.
  class LCSPFinder
    # @param {String} path
    # @param {String} number
    def initialize(path, number)
      @path = path
      @number = number
    end

    # @return {String}
    def solution
    end

    # @param {String} path
    # @param {String[]} dirs
    def fill_directories(path, dirs) end
  end
end
```

#### Reference class example

```ruby
# frozen_string_literal: true

module LCSP
  # Solutions finder.
  class LCSPFinder
    # @param {String} path
    # @param {String} number
    def initialize(path, number)
      @path = path
      @number = number
    end

    # @return {String}
    def solution
      dirs = []
      fill_directories(@path, dirs)

      dirs.each do |directory|
        ::Dir.foreach(directory) do |entry|
          return "#{directory}/#{entry}" if entry.start_with?(@number)
        end
      end
    end

    # @param {String} path
    # @param {String[]} dirs
    def fill_directories(path, dirs)
      ::Dir.foreach(path).reject { |name| name.start_with?('.') }.each do |entry|
        unless ::File.file?("#{path}/#{entry}")
          dirs << "#{path}/#{entry}"
          fill_directories("#{path}/#{entry}", dirs)
        end
      end
    end
  end
end
```

## Contributors

* [@fartem](https://github.com/fartem) as Artem Fomchenkov
