# frozen_string_literal: true

require_relative 'sheet_zoukas/data_converter'
require_relative 'sheet_zoukas/google_sheets'
require_relative 'sheet_zoukas/version'
require_relative 'sheet_zoukas/utils'

# Retrieve Google Sheets data
module SheetZoukas
  class Error < StandardError; end
  REQUIRED_VARS = %w[GOOGLE_ACCOUNT_TYPE GOOGLE_API_KEY GOOGLE_CLIENT_EMAIL GOOGLE_CLIENT_ID GOOGLE_PRIVATE_KEY].freeze

  class << self
    def retrieve_sheet_json(sheet_id, tab_name, range = nil)
      SheetZoukas.exit_program unless SheetZoukas::Utils.vars_present?(REQUIRED_VARS,
                                                                       'required for Google Sheets API calls')

      sheet = GoogleSheets.new
      data = sheet.retrieve_sheet(sheet_id, tab_name, range)
      DataConverter.new(data.values).convert
    end

    def exit_program
      exit 1
    end
  end
end
