require "pseudo_l10n/backend"

module PseudoL10n
  RSpec.describe Backend do
    context "when the current locale is not the pseudo locale" do
      it "does not modify the translated string" do
        expect(I18n.t("hello_world")).to eq("Hello world")
      end
    end

    context "when the current locale is the pseudo locale" do
      it "adds markers to translated strings" do
        I18n.with_locale(PseudoL10n.pseudo_locale) do
          expect(I18n.t("hello_world")).to start_with(Transformer::MARKER)
          expect(I18n.t("hello_world")).to end_with(Transformer::MARKER)
        end
      end
    end
  end
end
