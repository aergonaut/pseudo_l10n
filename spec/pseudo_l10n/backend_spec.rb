require "pseudo_l10n/backend"

module PseudoL10n
  RSpec.describe Backend do
    it "adds markers to translated strings" do
      expect(I18n.t("hello_world")).to start_with(Transformer::MARKER)
      expect(I18n.t("hello_world")).to end_with(Transformer::MARKER)
    end
  end
end
