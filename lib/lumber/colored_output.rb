
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
end
