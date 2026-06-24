# frozen_string_literal: true

require_relative "./abstract_line_tag"

module Markdown
  class OrderedListTag
    include AbstractLineTag

    protected

    def prefix_pattern
      /^(\d+)\.\s+/
    end

    def convert(string)
      string
    end

    public

    def process(line)
      match = line.match(prefix_pattern)
      content = line.sub(prefix_pattern, "")
      "  #{match[1]}. #{convert(content)}"
    end
  end
end
