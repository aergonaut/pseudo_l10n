RSpec.describe PseudoL10n do
  it "has a version number" do
    expect(PseudoL10n::VERSION).not_to be nil
  end

  # after do
  #   PseudoL10n.config.source_locale = nil
  #   PseudoL10n.config.pseudo_locale = nil
  # end

  describe ".source_locale" do
    it "defaults to en" do
      expect(PseudoL10n.source_locale).to eq :en
    end

    it "allows overriding" do
      PseudoL10n.config.source_locale = :de
      expect(PseudoL10n.source_locale).to eq :de
    end
  end

  describe ".pseudo_locale" do
    it "defaults to en-ZZ" do
      expect(PseudoL10n.pseudo_locale).to eq :"en-ZZ"
    end

    it "appends -ZZ to the source locale when not set" do
      PseudoL10n.config.source_locale = :de
      expect(PseudoL10n.pseudo_locale).to eq :"de-ZZ"
    end

    it "allows overriding" do
      PseudoL10n.config.pseudo_locale = :qps
      expect(PseudoL10n.pseudo_locale).to eq :qps
    end
  end
end
