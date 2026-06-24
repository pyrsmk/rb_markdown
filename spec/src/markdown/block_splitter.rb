RSpec.describe Markdown::BlockSplitter do
  subject { described_class.new }

  describe "#split" do
    context "with no code blocks" do
      it "returns a single text segment" do
        segments = subject.split("hello world")
        expect(segments.length).to eq 1
        expect(segments[0].type).to eq :text
        expect(segments[0].content).to eq "hello world"
        expect(segments[0].language).to be_nil
      end
    end

    context "with a code block" do
      it "returns text, code, and text segments" do
        input = "before\n```rb\nputs 'hi'\n```\nafter"
        segments = subject.split(input)

        expect(segments.length).to eq 3
        expect(segments[0]).to have_attributes(type: :text, content: "before")
        expect(segments[1]).to have_attributes(type: :code, content: "puts 'hi'", language: "rb")
        expect(segments[2]).to have_attributes(type: :text, content: "after")
      end
    end

    context "with a code block without language" do
      it "sets language to nil" do
        input = "```\nsome code\n```"
        segments = subject.split(input)

        expect(segments.length).to eq 1
        expect(segments[0]).to have_attributes(type: :code, content: "some code", language: nil)
      end
    end

    context "with multiple code blocks" do
      it "splits correctly" do
        input = "text1\n```js\nalert(1)\n```\ntext2\n```py\nprint(1)\n```\ntext3"
        segments = subject.split(input)

        expect(segments.length).to eq 5
        expect(segments.map(&:type)).to eq [:text, :code, :text, :code, :text]
        expect(segments[1].language).to eq "js"
        expect(segments[3].language).to eq "py"
      end
    end

    context "with a code block at the start" do
      it "does not produce an empty text segment" do
        input = "```rb\ncode\n```\nafter"
        segments = subject.split(input)

        expect(segments.length).to eq 2
        expect(segments[0]).to have_attributes(type: :code, content: "code")
        expect(segments[1]).to have_attributes(type: :text, content: "after")
      end
    end

    context "with an unclosed code block" do
      it "treats remaining content as code" do
        input = "before\n```rb\ncode without end"
        segments = subject.split(input)

        expect(segments.length).to eq 2
        expect(segments[0]).to have_attributes(type: :text, content: "before")
        expect(segments[1]).to have_attributes(type: :code, content: "code without end", language: "rb")
      end
    end

    context "with an empty code block" do
      it "produces a code segment with empty content" do
        input = "```rb\n```"
        segments = subject.split(input)

        expect(segments.length).to eq 1
        expect(segments[0]).to have_attributes(type: :code, content: "", language: "rb")
      end
    end
  end
end
