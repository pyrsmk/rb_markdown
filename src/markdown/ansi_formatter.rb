# frozen_string_literal: true

require "rouge"

module Markdown
  class AnsiFormatter < Rouge::Formatter
    COLOR_MAP = {
      "Comment"              => "90",
      "Comment.Preproc"      => "1;90",
      "Comment.Special"      => "1;3;90",
      "Error"                => "31",
      "Generic.Deleted"      => "31",
      "Generic.Emph"         => "3",
      "Generic.Error"        => "31",
      "Generic.Heading"      => "90",
      "Generic.Inserted"     => "32",
      "Generic.Output"       => "90",
      "Generic.Prompt"       => "90",
      "Generic.Strong"       => "1",
      "Generic.Subheading"   => "37",
      "Generic.Traceback"    => "31",
      "Keyword"              => "1;36",
      "Keyword.Namespace"    => "1;31",
      "Literal.Number"       => "35",
      "Literal.String"       => "33",
      "Literal.String.Affix" => "1;36",
      "Literal.String.Escape" => "35",
      "Name.Attribute"       => "32",
      "Name.Class"           => "1;32",
      "Name.Constant"        => "36",
      "Name.Decorator"       => "1;32",
      "Name.Exception"       => "1;32",
      "Name.Function"        => "1;32",
      "Name.Label"           => "1",
      "Name.Tag"             => "31",
      "Operator"             => "1;31",
      "Operator.Word"        => "1;31",
    }.freeze

    def stream(tokens, &b)
      tokens.each do |tok, val|
        code = ansi_code_for(tok)
        if code
          yield "\e[#{code}m"
          yield val
          yield "\e[0m"
        else
          yield val
        end
      end
    end

    private

    def ansi_code_for(token)
      @cache ||= {}
      @cache.fetch(token.qualname) { @cache[token.qualname] = resolve_code(token) }
    end

    def resolve_code(token)
      t = token
      while t
        return COLOR_MAP[t.qualname] if COLOR_MAP.key?(t.qualname)
        t = t.parent
      end
      nil
    end
  end
end
