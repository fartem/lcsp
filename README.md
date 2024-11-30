# lcsp

[![GitHubActions](https://github.com/fartem/lcsp/workflows/Build/badge.svg)](https://github.com/fartem/lcsp/actions?branch=master)
[![codebeat badge](https://codebeat.co/badges/eca07972-3b5a-4b3c-a424-a277ce8128b7)](https://codebeat.co/projects/github-com-fartem-lcsp-master)
[![Gem Version](https://badge.fury.io/rb/lcsp.svg)](https://badge.fury.io/rb/lcsp)
[![Gem Downloads](https://img.shields.io/gem/dt/lcsp)](https://badge.fury.io/rb/lcsp)

## About

A tool for showing solutions from LeetCode.

## How to use

### Installation

#### Download gem from RubyGems

```shell
$ gem i lcsp
```

#### As local installed gem

Build and install gem from sources:

```shell
$ gem build lcsp.gemspec
$ gem i lcsp
```

### Print solution

You need to provide 3 arguments for run `print` command:

| Parameter | Description       | Example         |
|-----------|-------------------|-----------------|
| `user`    | GitHub user name  | `fartem`        |
| `repo`    | Repository name   | `leetcode-ruby` |
| `number`  | Number of problem | `11`            |

One of valid input variants be like:

```shell
$ lcsp print --user=fartem --repo=leetcode-ruby --number=11
```

### Clean local cache

Just run next command from any folder:

```shell
$ lcsp clean
```

### Contacts

You can see actual author contacts by following command:

```shell
$ lcsp author
```

### Version

If you need to check installed version of `lcsp`, run from shell:

```shell
$ lcsp author
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
