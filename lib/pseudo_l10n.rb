require "pseudo_l10n/version"

module PseudoL10n
  def self.pseudo_locale=(locale)
    @pseudo_locale = locale.to_sym
  end

  def self.pseudo_locale
    @pseudo_locale
  end

  def self.source_locale=(locale)
    @source_locale = locale.to_sym
  end

  def self.source_locale
    @source_locale
  end
end

require "pseudo_l10n/transformer"
require "pseudo_l10n/backend"
