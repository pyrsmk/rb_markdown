# frozen_string_literal: true

module Markdown
  module AbstractLineTag
    def match?(line)
      line.match?(prefix_pattern)
    end

    def process(line)
      content = line.sub(prefix_pattern, "")
      convert(content)
    end

    protected

    # @return [Regexp]
    def prefix_pattern
      raise NotImplementedError
    end

    # @param string [String]
    # @return [String]
    def convert(string)
      raise NotImplementedError
    end
  end
end
