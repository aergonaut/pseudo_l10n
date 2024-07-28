require "dry/configurable"
require "pseudo_l10n/version"

module PseudoL10n
  extend Dry::Configurable

  setting :pseudo_locale, constructor: ->(val) { val&.to_sym }

  setting :source_locale,
          default: :en,
          reader: true,
          constructor: ->(val) { val&.to_sym }

  setting :ignored_keys,
          default: Set.new,
          reader: true,
          constructor: ->(val) { val&.to_set }

  def self.pseudo_locale
    config.pseudo_locale || :"#{config.source_locale}-ZZ"
  end
end

require "pseudo_l10n/transformer"
require "pseudo_l10n/backend"
