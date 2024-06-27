require "bundler/setup"
require "i18n"
require "pseudo_l10n"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

PseudoL10n.pseudo_locale = :"en-ZZ"
PseudoL10n.source_locale = :en

# Configure I18n to read from spec/config/locales and to use the backend
I18n.load_path += Dir[File.expand_path("../config/locales", __FILE__) + "/**/*.yml"]
I18n.default_locale = :en
I18n.backend = PseudoL10n::Backend.new(I18n.backend)
I18n.config.clear_available_locales_set
