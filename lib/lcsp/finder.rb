module LCSP
  class LCSPFinder
    def initialize(path, number)
      @path = path
      @number = number
    end

    def solution
      dirs = []
      fill_directories(@path, dirs)

      dirs.each do |directory|
        Dir.foreach(directory) do |entry|
          return "#{directory}/#{entry}" if entry.start_with? @number
        end
      end
    end

    def fill_directories(path, dirs)
      Dir.foreach(path).reject { |name| name.start_with? '.' }.each do |entry|
        unless File.file? "#{path}/#{entry}"
          dirs << "#{path}/#{entry}"
          fill_directories("#{path}/#{entry}", dirs)
        end
      end
    end
  end
end
