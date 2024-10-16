# frozen_string_literal: true

require 'json'

module SheetZoukas
  # convert spreadsheet data to JSON
  class DataConverter
    def initialize(data)
      @data = data
    end

    def convert
      init_headers
      init_rows

      @rows.map do |row|
        @headers.zip(row).to_h
      end.to_json
    end

    private

    def init_headers
      @headers = @data[0]
    end

    def init_rows
      @rows = @data[1..]
    end
  end
end
