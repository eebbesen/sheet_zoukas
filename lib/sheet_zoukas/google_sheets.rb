# frozen_string_literal: true

require 'google/apis/sheets_v4'
require 'googleauth'

module SheetZoukas
  # Interact with Google Sheets API
  class GoogleSheets
    DEFAULT_SCOPE = 'https://www.googleapis.com/auth/spreadsheets.readonly'

    def initialize(scope = DEFAULT_SCOPE)
      init_authorizer(scope)
    end

    def retrieve_sheet(sheet_id, tab_name, range = nil)
      sheets = Google::Apis::SheetsV4::SheetsService.new
      sheets.authorization = @authorizer

      computed_range = SheetZoukas::GoogleSheets.send :create_range, tab_name, range
      sheets.get_spreadsheet_values(sheet_id, computed_range)
    end

    private_class_method def self.create_range(tab_name, range = nil)
      return tab_name unless range

      "#{tab_name}!#{range}"
    end

    private

    # overriden in spec_helper so we don't try to authenticate with Google for tests
    def init_authorizer(scope)
      @authorizer = Google::Auth::ServiceAccountCredentials.from_env(scope: scope)
    end
  end
end
