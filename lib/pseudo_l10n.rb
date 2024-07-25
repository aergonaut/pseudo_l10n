require "pseudo_l10n/version"

module PseudoL10n
  def self.pseudo_locale=(locale)
    @pseudo_locale = locale&.to_sym
  end

  def self.pseudo_locale
    @pseudo_locale || :"#{source_locale}-ZZ"
  end

  def self.source_locale=(locale)
    @source_locale = locale&.to_sym
  end

  def self.source_locale
    @source_locale || :en
  end

  def self.ignored_keys
    @ignored_keys ||= Set.new
  end

  def self.ignored_keys=(keys)
    @ignored_keys = keys.to_set
  end
end

require "pseudo_l10n/transformer"
require "pseudo_l10n/backend"
