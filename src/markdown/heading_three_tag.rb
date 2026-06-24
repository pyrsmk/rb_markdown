# frozen_string_literal: true

require_relative "./abstract_line_tag"

module Markdown
  class HeadingThreeTag
    include AbstractLineTag

    protected

    def prefix_pattern
      /^###\s+/
    end

    def convert(string)
      string.bold.italic
    end
  end
end
