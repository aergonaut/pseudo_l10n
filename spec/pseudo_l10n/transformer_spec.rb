module PseudoL10n
  RSpec.describe Transformer do
    describe ".call" do
      let(:original) { "Hello world" }

      it "surrounds the original message with the marker character" do
        expect(Transformer.call(original)).to start_with(Transformer::MARKER)
        expect(Transformer.call(original)).to end_with(Transformer::MARKER)
      end
    end
  end
end
