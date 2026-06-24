# frozen_string_literal: true

require "rouge"

module Markdown
  class CodeBlockRenderer
    def render(content, language)
      lexer = Rouge::Lexer.find(language) if language
      lexer ||= Rouge::Lexers::PlainText.new

      formatter = Rouge::Formatters::Terminal256.new(Rouge::Themes::Monokai.new)
      formatter.format(lexer.lex(content))
    end
  end
end
