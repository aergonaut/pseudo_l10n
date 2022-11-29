module PseudoL10n
  class Backend
    attr_reader :original_backend

    def initialize(original_backend)
      @original_backend = original_backend
    end

    def method_missing?(name, *args, &block)
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
      original = original_backend.translate(locale, key, options)
      ::PseudoL10n::Transformer.call(original)
    end
  end
end
