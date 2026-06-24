# frozen_string_literal: true

module Markdown
  class BlockSplitter
    Segment = Struct.new(:type, :content, :language)

    def split(string)
      segments = []
      current_lines = []
      in_code_block = false
      language = nil

      string.each_line do |line|
        line = line.chomp

        if in_code_block
          if line.match?(/^```\s*$/)
            segments << Segment.new(:code, current_lines.join("\n"), language)
            current_lines = []
            in_code_block = false
            language = nil
          else
            current_lines << line
          end
        elsif (match = line.match(/^```(\w*)\s*$/))
          segments << Segment.new(:text, current_lines.join("\n")) unless current_lines.empty?
          current_lines = []
          in_code_block = true
          language = match[1].empty? ? nil : match[1]
        else
          current_lines << line
        end
      end

      unless current_lines.empty?
        segments << Segment.new(in_code_block ? :code : :text, current_lines.join("\n"), language)
      end

      segments
    end
  end
end
