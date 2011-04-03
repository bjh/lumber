

module Lumber
  class Config
    def initialize
      @colors = {}

      read_config_file()
    end

    def [](color)
      @colors[color.to_sym]
    end
    
  private

    def read_config_file
      # look for project .lumber file
      if File.exists?('.lumber')
        puts "FOUND LOCAL .lumber FILE"
        file = './lumber'
      else
      # look for ~/lumber as a backup
        file = "#{ENV['HOME']}/.lumber"
      end
      
      if File.exists? file
        parse_config(file)
      else
        @colors = make_defaults()
      end
    end

    def parse_config(file)
      File.open(file, 'r').each do |line|
        line.strip!
        parse_line(line) if line.size > 0
      end
    end

    def parse_line(line)
      parts = line.split(',').collect {|x| x.downcase.strip}

      @colors[parts[0].to_sym] = {
        :color => parts[1].to_sym,
        :bold => parts.size > 2 && parts[2] == 'bold'
      }
    end

    def make_defaults
      return {
        :info => {
          :color => :blue,
          :bold => true
        },
        :error => {
          :color => :red,
          :bold => false
        },
        :warn => {
          :color => :yellow,
          :bold => true
        },
        :debug => {
          :color => :magenta,
          :bold => true
        }
      }
    end
  end
end
