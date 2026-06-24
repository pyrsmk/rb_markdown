RSpec.describe Markdown::CodeBlockRenderer do
  subject { described_class.new }

  describe "#render" do
    context "with a known language" do
      it "returns a string containing ANSI escape codes" do
        result = subject.render("puts 'hello'", "rb")
        expect(result).to include("\033[")
      end
    end

    context "with an unknown language" do
      it "renders as plain text without crashing" do
        result = subject.render("some code", "nonexistentlang")
        expect(result).to be_a(String)
        expect(result).to include("some code")
      end
    end

    context "with nil language" do
      it "renders as plain text" do
        result = subject.render("some code", nil)
        expect(result).to be_a(String)
        expect(result).to include("some code")
      end
    end
  end
end
