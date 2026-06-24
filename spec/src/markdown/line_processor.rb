RSpec.describe Markdown::LineProcessor do
  subject { described_class.new(Markdown::InlineProcessor.new) }

  describe "#process" do
    context "with a heading" do
      it "applies heading formatting" do
        result = subject.process("# Hello")
        expect(result).to include("\033[4m")
        expect(result).to include("\033[1m")
        expect(result).to include("Hello")
      end
    end

    context "with inline markdown inside a heading" do
      it "applies both heading and inline formatting" do
        result = subject.process("# Hello **world**")
        expect(result).to include("\033[1m")
        expect(result).to include("world")
      end
    end

    context "with plain text" do
      it "applies only inline formatting" do
        result = subject.process("Hello **world**")
        expect(result).to include("\033[1m")
        expect(result).to include("world")
      end
    end

    context "with multiple lines" do
      it "processes each line independently" do
        input = "# Title\nsome text\n## Subtitle"
        result = subject.process(input)
        lines = result.split("\n")

        expect(lines[0]).to include("\033[4m")
        expect(lines[1]).to eq ""
        expect(lines[2]).to eq "some text"
        expect(lines[3]).to include("\033[1m")
      end
    end
  end
end
