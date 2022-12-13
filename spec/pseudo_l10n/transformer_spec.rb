module PseudoL10n
  RSpec.describe Transformer do
    describe ".call" do
      context "when given a string" do
        let(:original) { "Hello world" }

        it "surrounds the original message with the marker character" do
          expect(Transformer.call(original)).to start_with(Transformer::MARKER)
          expect(Transformer.call(original)).to end_with(Transformer::MARKER)
        end
      end

      context "when given a Hash" do
        let(:original) { { foo: :bar, x: "hello world" } }
        subject { Transformer.call(original) }

        it "transforms keys that lead to Strings" do
          expect(subject[:x]).to start_with(Transformer::MARKER)
          expect(subject[:x]).to end_with(Transformer::MARKER)
        end

        it "preserves keys that lead to non-Strings" do
          expect(subject[:foo]).to eq(original[:foo])
        end
      end

      context "when given an Array" do
        let(:original) { ["hello world", :a] }
        subject { Transformer.call(original) }

        it "transforms String elements" do
          expect(subject[0]).to start_with(Transformer::MARKER)
          expect(subject[0]).to end_with(Transformer::MARKER)
        end

        it "preserves non-String elements" do
          expect(subject[1]).to eq(original[1])
        end
      end
    end
  end
end
