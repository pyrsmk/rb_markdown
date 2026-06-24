RSpec.describe Markdown::Engine do
  describe "#to_ansi" do
    context "with inline formatting" do
      it "applies bold" do
        result = described_class.new("hello **world**").to_ansi
        expect(result).to include("\033[1m")
        expect(result).to include("world")
      end

      it "applies italic" do
        result = described_class.new("hello *world*").to_ansi
        expect(result).to include("\033[3m")
      end

      it "applies inline code" do
        result = described_class.new("hello `world`").to_ansi
        expect(result).to include("\033[36m")
      end
    end

    context "with headings" do
      it "applies h1 formatting" do
        result = described_class.new("# Title").to_ansi
        expect(result).to include("\033[33m")
        expect(result).to include("\033[4m")
        expect(result).to include("\033[1m")
        expect(result).to include("Title")
      end

      it "applies h2 formatting" do
        result = described_class.new("## Subtitle").to_ansi
        expect(result).to include("\033[33m")
        expect(result).to include("\033[1m")
        expect(result).to include("Subtitle")
      end

      it "preserves inline markers inside headings" do
        result = described_class.new("# Hello **world**").to_ansi
        expect(result).to include("Hello **world**")
        expect(result).to include("\033[4m")
      end
    end

    context "with code blocks" do
      it "applies syntax highlighting" do
        input = "```rb\nputs 'hello'\n```"
        result = described_class.new(input).to_ansi
        expect(result).to include("\033[")
        expect(result).to include("puts")
      end

      it "does not apply inline formatting inside code blocks" do
        input = "```\n**not bold**\n```"
        result = described_class.new(input).to_ansi
        expect(result).to include("**not bold**")
      end
    end

    context "with lists" do
      it "renders unordered list items with bullets" do
        result = described_class.new("- item one\n- item two").to_ansi
        expect(result).to include("\u2022 item one")
        expect(result).to include("\u2022 item two")
      end

      it "renders ordered list items with numbers" do
        result = described_class.new("1. first\n2. second").to_ansi
        expect(result).to include("1. first")
        expect(result).to include("2. second")
      end

      it "applies inline formatting inside list items" do
        result = described_class.new("- **bold item**").to_ansi
        expect(result).to include("\033[1m")
        expect(result).to include("bold item")
      end
    end

    context "with a full document" do
      it "processes all elements correctly" do
        input = [
          "# Main Title",
          "",
          "Some **bold** and *italic* text.",
          "",
          "## Section",
          "",
          "- item one",
          "- item **two**",
          "",
          "1. first",
          "2. second",
          "",
          "```rb",
          "puts 'hello'",
          "```",
          "",
          "End of document.",
        ].join("\n")

        result = described_class.new(input).to_ansi

        expect(result).to include("Main Title")
        expect(result).to include("\u2022 item one")
        expect(result).to include("puts")
        expect(result).to include("End of document.")
      end
    end
  end
end
