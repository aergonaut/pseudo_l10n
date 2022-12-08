module PseudoL10n
  class Backend
    attr_reader :original_backend

    def initialize(original_backend)
      @original_backend = original_backend
    end

    def method_missing(name, *args, &block)
      if respond_to_missing?(name)
        original_backend.public_send(name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      original_backend.respond_to?(name) || super
    end

    def translate(locale, key, options)
      if locale.to_sym == PseudoL10n.pseudo_locale
        locale = PseudoL10n.source_locale
        original = original_backend.translate(locale, key, options)
        ::PseudoL10n::Transformer.call(original)
      else
        original_backend.translate(locale, key, options)
      end
    end

    def available_locales
      available = original_backend.available_locales
      available << PseudoL10n.pseudo_locale
    end

    protected

    def init_translations
      original_backend.send(:init_translations)
    end
  end
end
