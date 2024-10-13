# SheetZoukas

Expose Google Sheets as JSON data

![Tests](https://github.com/eebbesen/sheet_zoukas/actions/workflows/ruby.yml/badge.svg)

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

Created to allow Google Sheets to be used as read-only databases. Associates each row's values with the corresponding header ("row") name.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add sheet_zoukas

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install sheet_zoukas

## Usage

### Requirements

This gem assumes the existence of a [Google service account](https://developers.google.com/identity/protocols/oauth2/service-account) with [the Google Sheets API](https://console.cloud.google.com/apis/library/sheets.googleapis.com) enabled. Several environment variables are required for this gem to work.

#### Google auth values

* GOOGLE_ACCOUNT_TYPE
* GOOGLE_API_KEY
* GOOGLE_CLIENT_EMAIL
* GOOGLE_CLIENT_ID
* GOOGLE_PRIVATE_KEY


### Notes
* All data exposed as Strings. You can convert data to other types as you ingest this gem's output.
* All data is exposed as the display value
    * This impacts dates. For example, if your spreadsheet does not display the year as part of a date, this gem will not include a year in it's output for those cells.
* No `nil` values, just empty Strings. You can convert empty strings to `nil` as you ingest this gem's output.
* Row values outside of header range will not be captured. You must have a non-blank header for the row data to be included in this gem's output.
* Performance: this gem has not been tested with large Google Sheets. If you encounter performance issues consider passing in cell ranges to iteratively get your dataset ala pagination.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### linting

GitHub Action runs
* RuboCop
* Bundler Audit

### testing

RSpec tests require the environment variables listed in spec_helper.rb's `REQUIRED_VARS` constant. Out of the box your tests that call Google (mocked with VCR) will fail because you do (should) not have access to my test account credentials.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eebbesen/sheet_zoukas.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
