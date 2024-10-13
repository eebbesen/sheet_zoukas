# frozen_string_literal: true

require 'sheet_zoukas'
require 'simplecov'
require 'vcr'
require 'webmock/rspec'

require 'byebug'

SimpleCov.start do
  enable_coverage :branch
  add_filter 'spec/'
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<GOOGLE_API_KEY>') { ENV.fetch('GOOGLE_API_KEY', nil) }
  config.filter_sensitive_data('<SPREADSHEET_ID>') { ENV.fetch('GOOGLE_API_SPREADSHEET_ID', nil) }
end

def check_vars
  %w[GOOGLE_ACCOUNT_TYPE GOOGLE_API_KEY GOOGLE_CLIENT_EMAIL GOOGLE_CLIENT_ID GOOGLE_PRIVATE_KEY].each do |var|
    next if ENV.fetch(var, nil)

    puts '----------------------------------------------------------------'
    puts "Please set the #{var} environment variable for the tests to run."
    puts '----------------------------------------------------------------'
    exit 1
  end
end

check_vars
