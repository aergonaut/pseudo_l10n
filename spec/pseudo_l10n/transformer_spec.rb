module PseudoL10n
  RSpec.describe Transformer do
    describe ".call" do
      context "when given a string" do
        it "surrounds the original message with the marker character" do
          expect(Transformer.call("Hello world")).to start_with(Transformer::MARKER)
          expect(Transformer.call("Hello world")).to end_with(Transformer::MARKER)
        end

        it "lengthens the string by replacing half-width characters with full-width" do
          expect(Transformer.call("Hello world")).to eq("√Ｈｅｌｌｏ ｗｏｒｌｄ√")
        end

        it "does not change HTML tags" do
          expect(Transformer.call("<p>Hello world</p>")).to eq("√<p>Ｈｅｌｌｏ ｗｏｒｌｄ</p>√")
        end

        it "does not change interpolation variables" do
          expect(Transformer.call("Hello %{world}")).to eq("√Ｈｅｌｌｏ %{world}√")
        end

        it "does not change URLs" do
          expect(Transformer.call("http://example.com")).to eq("√http://example.com√")
        end
      end

      context "when given a Hash" do
        let(:original) { {foo: :bar, x: "hello world"} }

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
