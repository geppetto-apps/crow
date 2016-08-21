require "./noop_renderer"

class Markdown
  class ExampleSpecRenderer < NoopRenderer
    def initialize
      @state = "pending"
      @title = ""
      @crystal_example = ""
      @flow_example = ""
    end

    def begin_header(level)
      @state = "title"
      @title = ""
    end

    def end_header(level)
      @state = "pending"
    end

    def begin_code(language)
      case language
      when "crystal"
        @state = "crystal_example"
        @crystal_example = ""
      when "js"
        @state = "flow_example"
        @flow_example = ""
      end
    end

    def end_code
      @state = "pending"

      if has_all_info
        title = @title
        code_example(title, @crystal_example.strip, @flow_example.strip)
        @title = ""
        @crystal_example = ""
        @flow_example = ""
      end
    end

    def text(text)
      case @state
      when "title"
        @title += text
      when "crystal_example"
        @crystal_example += text
      when "flow_example"
        @flow_example += text
      end
    end

    private def has_all_info
      @title.size > 0 && @crystal_example.size > 0 && @flow_example.size > 0
    end
  end
end
