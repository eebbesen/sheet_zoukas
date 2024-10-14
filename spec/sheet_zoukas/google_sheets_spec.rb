# frozen_string_literal: true

require 'spec_helper'
require 'sheet_zoukas/google_sheets'

RSpec.describe SheetZoukas::GoogleSheets do
  before { ENV.store('GOOGLE_API_SPREADSHEET_ID_TEST', 'test_id') }

  describe '#initialize' do
    it 'uses default scope' do
      ret = described_class.new.instance_variable_get(:@authorizer).scope
      expect(ret.first).to eq(described_class::DEFAULT_SCOPE)
    end

    it 'uses passed-in scope' do
      scope = 'https://www.googleapis.com/auth/spreadsheets'
      ret = described_class.new(scope).instance_variable_get(:@authorizer).scope
      expect(ret.first).to eq(scope)
    end
  end

  describe '.create_range' do
    it 'returns range when no tab' do
      range = described_class.send :create_range, 'sheet_2'
      expect(range).to eq('sheet_2')
    end

    it 'returns range and tab when no tab' do
      range = described_class.send :create_range, 'sheet_2', 'A1:B2'
      expect(range).to eq('sheet_2!A1:B2')
    end
  end

  describe '#retrieve_sheet' do
    it 'retrieves sheet with range' do
      VCR.use_cassette('get_spreadsheet_values_range') do
        sheet = described_class.new.retrieve_sheet(ENV.fetch('GOOGLE_API_SPREADSHEET_ID_TEST', nil), 'Log', 'A:Z')
        expect(sheet.values.first).to include('Reward Type')
      end
    end

    it 'retrieves sheet without range' do
      VCR.use_cassette('get_spreadsheet_values_no_range') do
        sheet = described_class.new.retrieve_sheet(ENV.fetch('GOOGLE_API_SPREADSHEET_ID_TEST', nil), 'Log')
        expect(sheet.values.first).to include('Reward Type')
      end
    end
  end
end
