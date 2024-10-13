# frozen_string_literal: true

require_relative 'sheet_zoukas/data_converter'
require_relative 'sheet_zoukas/google_sheets'
require_relative 'sheet_zoukas/version'

# Retrieve Google Sheets data
module SheetZoukas
  class Error < StandardError; end

  class << self
    def retrieve_sheet_json(sheet_id, tab_name, range = nil)
      sheet = GoogleSheets.new
      data = sheet.retrieve_sheet(sheet_id, tab_name, range)
      DataConverter.new(data.values).convert
    end
  end
end
