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
      @heading_tags = [
        HeadingThreeTag.new,
        HeadingTwoTag.new,
        HeadingOneTag.new,
      ]
      @line_tags = @heading_tags + [
        UnorderedListTag.new,
        OrderedListTag.new,
      ]
    end

    def process(string)
      lines = string.each_line(chomp: true).to_a
      result = []
      skip_next_blank = false

      lines.each do |line|
        if skip_next_blank && line.strip.empty?
          skip_next_blank = false
          next
        end
        skip_next_blank = false

        tag = @line_tags.find { |t| t.match?(line) }

        processed = if tag
          tagged = tag.process(line)
          @heading_tags.include?(tag) ? tagged : @inline_processor.process(tagged)
        else
          @inline_processor.process(line)
        end

        result << processed

        if tag && @heading_tags.include?(tag)
          result << ""
          skip_next_blank = true
        end
      end

      result.join("\n")
    end
  end
end
