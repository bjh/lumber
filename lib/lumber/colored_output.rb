
module Lumber
  # handles coloring Logger output
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
      color(:error, message)
    end

    def _info(message)
      color(:info, message)
    end

    def _warn(message)
      color(:warn, message)
    end

    def _debug(message)
      color(:debug, message)
    end

    def colon
      ANSI.color(:black, :bold => true) {": "}
    end

    def border(size=1)
      "-" * size
    end

    def color(level, message)
      color = CONFIG[level.to_sym]
      _format(ANSI.color(color[:color], :bold => color[:bold]) { "#{message}" })
    end
  end
end
