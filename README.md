# lcsp

[![GitHubActions](https://github.com/fartem/distincter2/workflows/Build/badge.svg)](https://github.com/fartem/distincter2/actions?branch=master)
[![codebeat badge](https://codebeat.co/badges/eca07972-3b5a-4b3c-a424-a277ce8128b7)](https://codebeat.co/projects/github-com-fartem-lcsp-master)
[![Gem Version](https://badge.fury.io/rb/lcsp.svg)](https://badge.fury.io/rb/lcsp)
[![Gem Downloads](https://img.shields.io/gem/dt/lcsp)](https://badge.fury.io/rb/lcsp)

## About

A tool for showing and counting solutions from LeetCode.

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
| --------- | ----------------- | --------------- |
| `user`    | GitHub user name  | `fartem`        |
| `repo`    | Repository name   | `leetcode-ruby` |
| `number`  | Number of problem | `11`            |

One of valid input variants be like:

```shell
$ lcsp print --user=fartem --repo=leetcode-ruby --number=11
```

### Count solutions

You need to provide 2 arguments for run `count` command:

| Parameter | Description      | Example         |
| --------- | ---------------- | --------------- |
| `user`    | GitHub user name | `fartem`        |
| `repo`    | Repository name  | `leetcode-ruby` |

One of valid input variants be like:

```shell
$ lcsp count --user=fartem --repo=leetcode-ruby
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

### How to write your own `LCSPFinder`

#### Read before start

`lcsp` works with custom finders - classes that should placed in your project and that will perform
search locally.

You need to write finder classes in Ruby because only this format accepting right now, but all work
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

### How to write your own `LCSCCounter`

#### Read before start

`lcsc` works with custom counters - classes that should placed in your project and that will perform
search locally.

You need to write counter classes in Ruby because only this format accepting right now, but all work
around search and parse for your repository you can place in classes/scripts/files in any other programming language.

One of the correct and working example available
by [this link](https://github.com/fartem/leetcode-ruby/blob/master/lcsp/counter.rb).

#### Template class

`path` are default parameter that are presenting for every repository. It is a path to repository in cache.
```ruby
# frozen_string_literal: true

module LCSC
  # Solutions finder.
  class LCSCCounter
    # @param {String} path
    def initialize(path)
      @path = path
    end

    # @return {Integer}
    def count
    end
  end
end
```

#### Reference class example

```ruby
# frozen_string_literal: true

module LCSC
  # Solutions finder.
  class LCSCFinder
    # @param {String} path
    def initialize(path)
      @path = path
    end

    # @return {Integer}
    def count
      dirs = []
      fill_directories(@path, dirs)

      dirs.each do |directory|
        ::Dir.foreach(directory) do |entry|
          return "#{directory}/#{entry}" if entry.start_with?(@number)
        end
      end
    end
  end
end
```

## Contributors

* [@fartem](https://github.com/fartem) as Artem Fomchenkov
