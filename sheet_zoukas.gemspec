# frozen_string_literal: true

require_relative 'lib/sheet_zoukas/version'

Gem::Specification.new do |spec|
  spec.name = 'sheet_zoukas'
  spec.version = SheetZoukas::VERSION
  spec.authors = ['eebbesen']
  spec.email = ['eebbesen.git@gmail.com']

  spec.summary = 'Expose Google Sheets as JSON data'
  spec.description = 'Expose Google Sheets as JSON data'
  spec.homepage = 'https://github.com/eebbesen/sheet_zoukas'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata = {
    'homepage_uri' => 'https://github.com/eebbesen/sheet_zoukas',
    'changelog_uri' => "https://github.com/eebbesen/sheet_zoukas/releases/tag/v#{SheetZoukas::VERSION}",
    'source_code_uri' => 'https://github.com/eebbesen/sheet_zoukas',
    'documentation_uri' => 'https://github.com/eebbesen/sheet_zoukas',
    'bug_tracker_uri' => 'https://github.com/eebbesen/sheet_zoukas/issues',
    'rubygems_mfa_required' => 'true'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # spec.add_development_dependency 'rspec'
  spec.add_dependency 'google-apis-sheets_v4'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
