# frozen_string_literal: true

require_relative "./bold_tag"
require_relative "./code_tag"
require_relative "./italic_tag"

module Markdown
  class InlineProcessor
    def process(string)
      CodeTag.new(ItalicTag.new(BoldTag.new(string))).to_ansi
    end
  end
end
