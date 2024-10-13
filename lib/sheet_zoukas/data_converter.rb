# frozen_string_literal: true

module SheetZoukas
  # convert spreadsheet data to JSON
  class DataConverter
    def initialize(data)
      @data = data
    end

    private

    def init_headers
      @headers = @data[0]
    end
  end
end
