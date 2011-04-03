
require 'logger'
require 'ansi'
require 'lumber/config'
require 'lumber/colored_output'

# miniscule wrapper around Ruby's Logger class
module Lumber  
  CONFIG = Lumber::Config.new
  
  @logger = Logger.new($stdout)
  @logger.datetime_format = "%H:%M "
  
  @logger.formatter = Lumber::ColoredOutput.new

  # attach methods now instead of using method_missing
  methods = %w{datetime_format level error info warn debug}

  
  class << self
    methods.each do |method|
      define_method(method) do |*args|
        @logger.send(method, *args)
      end
    end
  end

  # def self.date_time_format(format)
  #   @logger.datetime_format = format
  # end
  
  # def level(log_level)
  #   @logger.level = log_level
  # end
  
  # def self.error(message)
  #   @logger.error(message)
  # end
  
  # def self.info(message)
  #   @logger.info(message)
  # end

  # def self.warn(message)
  #   @logger.warn(message)
  # end
  
  # def self.debug(message)
  #   @logger.debug(message)
  # end
end



