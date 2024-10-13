# frozen_string_literal: true

require 'spec_helper'
require 'sheet_zoukas/data_converter'

DATA = [
  ['Place',
   'Deal',
   'Deal Earned',
   'Deal Used',
   'Deal Starts',
   'Deal Ends',
   'Notes',
   'Money Saved',
   'Reward Type'],
  ['Slice Brothers',
   '2 slices for $5.99',
   '',
   '03/30/2024',
   '',
   '',
   'no longer active',
   '4.99',
   'no longer active',
   '',
   'TOTAL SAVED',
   '124.15'],
  ['Slice Brothers',
   '2 slices for $5.99',
   '',
   '04/11/2024',
   '',
   '',
   'no longer active',
   '4.99',
   'no longer active'],
  ['Pot Belly',
   '1 free sandwich with the purchase of sandwich between 04/01 and 04/07',
   '04/04/2024',
   '04/08/2024',
   '04/01/2024',
   '04/07/2024',
   '',
   '10.66',
   'rewards']
].freeze

RSpec.describe SheetZoukas::DataConverter do
  describe '#init_headers' do
    it 'initializes headers' do
      dc = described_class.new(DATA)
      dc.send :init_headers

      expect(dc.instance_variable_get(:@headers)).to eq(DATA[0])
    end

    it 'handles empty sheet' do
      dc = described_class.new([[], []])
      dc.send :init_headers

      expect(dc.instance_variable_get(:@headers)).to eq([])
    end
  end
end
