module LCSP
  # Solutions finder.
  class LCSPFinder
    # Pass path to solution (repository from GitHub)
    # and LeetCode problem number
    # to find solution in repository.
    # @param path {String}
    # @param number {String}
    def initialize(path, number)
      @path = path
      @number = number
    end

    # Find solution with passed params.
    def solution
      dirs = []
      fill_directories(@path, dirs)

      dirs.each do |directory|
        ::Dir.foreach(directory) do |entry|
          return "#{directory}/#{entry}" if entry.start_with?(@number)
        end
      end
    end

    # Find all directories in repository.
    def fill_directories(path, dirs)
      Dir.foreach(path).reject { |name| name.start_with?('.') }.each do |entry|
        unless File.file?("#{path}/#{entry}")
          dirs << "#{path}/#{entry}"
          fill_directories("#{path}/#{entry}", dirs)
        end
      end
    end
  end
end
