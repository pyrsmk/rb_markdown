# frozen_string_literal: true

require_relative "./heading_three_tag"
require_relative "./heading_two_tag"
require_relative "./heading_one_tag"
require_relative "./unordered_list_tag"
require_relative "./ordered_list_tag"

module Markdown
  class LineProcessor
    def initialize(inline_processor)
      @inline_processor = inline_processor
      @line_tags = [
        HeadingThreeTag.new,
        HeadingTwoTag.new,
        HeadingOneTag.new,
        UnorderedListTag.new,
        OrderedListTag.new,
      ]
    end

    def process(string)
      string.each_line(chomp: true).map do |line|
        tag = @line_tags.find { |t| t.match?(line) }

        if tag
          @inline_processor.process(tag.process(line))
        else
          @inline_processor.process(line)
        end
      end.join("\n")
    end
  end
end
