RSpec.describe Markdown::OrderedListTag do
  subject { described_class.new }

  let(:content) { SecureRandom.hex }

  describe "#match?" do
    it "matches lines starting with a number and dot" do
      expect(subject.match?("1. #{content}")).to be true
      expect(subject.match?("42. #{content}")).to be true
    end

    it "does not match lines without a list prefix" do
      expect(subject.match?(content)).to be false
    end
  end

  describe "#process" do
    it "preserves the number with indentation" do
      result = subject.process("1. #{content}")
      expect(result).to eq "  1. #{content}"
    end

    it "handles multi-digit numbers" do
      result = subject.process("42. #{content}")
      expect(result).to eq "  42. #{content}"
    end
  end
end
