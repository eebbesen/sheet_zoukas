# SheetZoukas

Expose Google Sheets as JSON data

![Tests](https://github.com/eebbesen/sheet_zoukas/actions/workflows/ruby.yml/badge.svg)

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add sheet_zoukas

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install sheet_zoukas

## Usage

Expose Google Sheets as JSON data.

Created to allow Google Sheets to be used as read-only databases. Associates each row's values with the corresponding header ("row") name.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### linting

GitHub Action runs
* RuboCop
* Bundler Audit

### testing

RSpec tests require the environment variables listed in spec_helper.rb's `REQUIRED_VARS` constant.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eebbesen/sheet_zoukas.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
