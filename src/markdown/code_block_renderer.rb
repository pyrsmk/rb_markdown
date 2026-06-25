# frozen_string_literal: true

require "rouge"
require_relative "./ansi_formatter"

module Markdown
  class CodeBlockRenderer
    def render(content, language)
      lexer = Rouge::Lexer.find(language) if language
      lexer ||= Rouge::Lexers::PlainText.new

      AnsiFormatter.new.format(lexer.lex(content))
    end
  end
end
