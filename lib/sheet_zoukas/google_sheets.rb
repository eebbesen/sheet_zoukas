# frozen_string_literal: true

require 'google/apis/sheets_v4'
require 'googleauth'

module SheetZoukas
  # Interact with Google Sheets API
  class GoogleSheets
    DEFAULT_SCOPE = 'https://www.googleapis.com/auth/drive.readonly'

    def initialize(scope = DEFAULT_SCOPE)
      @authorizer = Google::Auth::ServiceAccountCredentials.from_env(scope: scope)
    end

    def retrieve_sheet(sheet_id, range, tab_name)
      sheets = Google::Apis::SheetsV4::SheetsService.new
      sheets.authorization = @authorizer

      computed_range = create_range(range, tab_name)
      sheets.get_spreadsheet_values(sheet_id, computed_range)
    end

    class << self
      private

      def create_range(range, tab_name = nil)
        return range unless tab_name

        "#{tab_name}!#{range}"
      end
    end
  end
end
