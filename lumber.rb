require 'logger'

begin
  require 'ansi'
  $ansi_included = true
rescue LoadError => error
  puts "need to run 'gem install ssoroka-ansi' to get colored log output"
  $ansi_included = false
end

# small wrapper around Ruby's Logger class
# to get colored output and simple messages
module Lumber
  # handles coloring Logger output if available
  class ColoredOutput < Logger::Formatter    
    # intercept calls to Logger
    def call(severity, time, program_name, message)
      severity = "_#{severity.downcase}".to_sym      
      begin
        self.send(severity, message)
      rescue
        super
      end
    end    
  private  
    def _format(message)
      msg = colon() + message      
      #[border(), msg, border()].join("\n") + "\n"
      "#{msg}\n"
    end

    def _error(message)
      _format(ANSI.color(:red, :bold => true) { "#{message}" })
    end

    def _info(message)
      _format(ANSI.color(:yellow, :bold => true) { "#{message}" })
    end

    def _warn(message)
      _format(ANSI.color(:magenta, :bold => true) { "#{message}" })
    end

    def _debug(message)
      _format(ANSI.color(:cyan, :bold => true) { "#{message}" })
    end

    def colon
      ANSI.color(:black, :bold => true) {": "}
    end

    def border(size=1)
      "-" * size
    end  
  end
  
  #------------------------------------------------
  
  # module level variable
  @logger = Logger.new($stdout)
  @logger.datetime_format = "%H:%M "
  
  if $ansi_included
    @logger.formatter = ColoredOutput.new
  end

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



