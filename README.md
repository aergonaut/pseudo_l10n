# `PseudoL10n`

`PseudoL10n` is a simple gem to add pseudolocalization to Ruby projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pseudo_l10n'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pseudo_l10n

## Usage

### Integration with `I18n`

This gem provides a `PseudoL10n::Backend` class that is compatible with the `i18n` gem to provide automatic pseudolocalization to your project.

To use the backend, wrap your existing `I18n.backend` with the `Backend` class from this gem:

```ruby
I18n.backend = PseudoL10n::Backend.new(I18n.backend)
```

### Pseudo-Locale

To activate pseudolocalization, set the current `I18n.locale` to the special pseudo-locale code `:en-ZZ`. This should not be any locale code that you app actually uses. If you need to change the default, you can change it in configuration:

```ruby
PseudoL10n.pseudo_locale = :"en-ZZ"
```

The pseudo-locale will apply various transformations to strings from the source locale. The source locale is by default `:en`. This can also be changed in configuration:

```ruby
PseudoL10n.source_locale = :en
```

### Low-level Transformer API

This gem also provides a low-level transformer API. This can be used to transform a string according to pseudolocale rules.

```ruby
message = "Hello world"

PseudoL10n::Transformer.call(message)
# => "√Hello world√"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pseudo_l10n. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PseudoL10n project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pseudo_l10n/blob/master/CODE_OF_CONDUCT.md).
