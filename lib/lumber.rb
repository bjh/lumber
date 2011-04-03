
require 'logger'
require 'ansi'
require 'lumber/config'
require 'lumber/colored_output'

# miniscule wrapper around Ruby's Logger class
module Lumber  
  CONFIG = Lumber::Config.new
  
  @@logger ||= Logger.new($stdout)
  @@logger.datetime_format = "%H:%M "
  
  @@logger.formatter = Lumber::ColoredOutput.new

  class << self
    def method_missing(method, *args, &block)
      if @@logger.respond_to?(method)
        @@logger.send(method, *args)
      else
        @@logger.warn "Lumber::method_missing - does not respond to #{method}"
      end
    end
  end
end

