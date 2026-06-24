# frozen_string_literal: true

require_relative "./block_splitter"
require_relative "./code_block_renderer"
require_relative "./inline_processor"
require_relative "./line_processor"

module Markdown
  class Engine
    def initialize(string)
      @string = string
    end

    def to_ansi
      line_processor = LineProcessor.new(InlineProcessor.new)
      code_renderer = CodeBlockRenderer.new

      BlockSplitter.new.split(@string).map do |segment|
        case segment.type
        when :text
          line_processor.process(segment.content)
        when :code
          code_renderer.render(segment.content, segment.language)
        end
      end.join("\n")
    end
  end
end
