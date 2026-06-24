RSpec.describe Markdown::UnorderedListTag do
  subject { described_class.new }

  let(:content) { SecureRandom.hex }

  describe "#match?" do
    it "matches lines starting with -" do
      expect(subject.match?("- #{content}")).to be true
    end

    it "matches lines starting with *" do
      expect(subject.match?("* #{content}")).to be true
    end

    it "does not match lines without a list prefix" do
      expect(subject.match?(content)).to be false
    end
  end

  describe "#process" do
    it "replaces - with a bullet" do
      result = subject.process("- #{content}")
      expect(result).to eq "  \u2022 #{content}"
    end

    it "replaces * with a bullet" do
      result = subject.process("* #{content}")
      expect(result).to eq "  \u2022 #{content}"
    end
  end
end
