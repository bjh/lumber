
require 'logger'
require 'ansi'
require 'lumber/config'
require 'lumber/colored_output'

# small wrapper around Ruby's Logger class
module Lumber  
  # module level variable
  CONFIG = Lumber::Config.new
  
  @logger = Logger.new($stdout)
  @logger.datetime_format = "%H:%M "
  
  @logger.formatter = Lumber::ColoredOutput.new

  def self.date_time_format(format)
    @logger.datetime_format = format
  end
  
  def level(log_level)
    @logger.level = log_level
  end
  
  def self.error(message)
    @logger.error(message)
  end
  
  def self.info(message)
    @logger.info(message)
  end

  def self.warn(message)
    @logger.warn(message)
  end
  
  def self.debug(message)
    @logger.debug(message)
  end
end



