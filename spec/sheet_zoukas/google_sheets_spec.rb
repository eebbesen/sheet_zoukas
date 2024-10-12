# frozen_string_literal: true

require 'spec_helper'
require 'sheet_zoukas/google_sheets'

RSpec.describe SheetZoukas::GoogleSheets do
  describe '.create_range' do
    it 'returns range when no tab' do
      range = described_class.send :create_range, 'A1:B2'
      expect(range).to eq('A1:B2')
    end

    it 'returns range and tab when no tab' do
      range = described_class.send :create_range, 'A1:B2', 'sheet_2'
      expect(range).to eq('sheet_2!A1:B2')
    end
  end
end
