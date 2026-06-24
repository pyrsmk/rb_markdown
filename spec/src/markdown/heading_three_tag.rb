RSpec.describe Markdown::HeadingThreeTag do
  subject { described_class.new }

  let(:content) { SecureRandom.hex }

  describe "#match?" do
    it "matches lines starting with ###" do
      expect(subject.match?("### #{content}")).to be true
    end

    it "does not match # or ##" do
      expect(subject.match?("# #{content}")).to be false
      expect(subject.match?("## #{content}")).to be false
    end
  end

  describe "#process" do
    it "returns bold italic content" do
      result = subject.process("### #{content}")
      expect(result).to eq "\033[33m\033[3m#{content}\033[0m\033[0m"
    end
  end
end
