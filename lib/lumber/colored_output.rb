
module Lumber
  # handles coloring Logger output if available
  class ColoredOutput < Logger::Formatter
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
      color = CONFIG[:error]
      _format(ANSI.color(color[:color], :bold => color[:bold]) { "#{message}" })
    end

    def _info(message)
      color = CONFIG[:info]
      _format(ANSI.color(color[:color], :bold => color[:bold]) { "#{message}" })
    end

    def _warn(message)
      color = CONFIG[:warn]
      _format(ANSI.color(color[:color], :bold => color[:bold]) { "#{message}" })
    end

    def _debug(message)
      color = CONFIG[:debug]
      _format(ANSI.color(color[:color], :bold => color[:bold]) { "#{message}" })
    end

    def colon
      ANSI.color(:black, :bold => true) {": "}
    end

    def border(size=1)
      "-" * size
    end  
  end
end
