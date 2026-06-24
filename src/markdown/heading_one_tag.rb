# frozen_string_literal: true

require_relative "./abstract_line_tag"

module Markdown
  class HeadingOneTag
    include AbstractLineTag

    protected

    def prefix_pattern
      /^#\s+/
    end

    def convert(string)
      string.bold.underline.yellow
    end
  end
end
