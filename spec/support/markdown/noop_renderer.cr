class Markdown
  class NoopRenderer
    include Markdown::Renderer

    def begin_paragraph
    end

    def end_paragraph
    end

    def begin_italic
    end

    def end_italic
    end

    def begin_bold
    end

    def end_bold
    end

    def begin_header(level)
    end

    def end_header(level)
    end

    def begin_inline_code
    end

    def end_inline_code
    end

    def begin_code(language)
    end

    def end_code
    end

    def begin_quote
    end

    def end_quote
    end

    def begin_unordered_list
    end

    def begin_ordered_list
    end

    def end_unordered_list
    end

    def end_ordered_list
    end

    def begin_list_item
    end

    def end_list_item
    end

    def begin_link(url)
    end

    def end_link
    end

    def image(url, alt)
    end

    def text(text)
    end

    def horizontal_rule
    end
  end
end
