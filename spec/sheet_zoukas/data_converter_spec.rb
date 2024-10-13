# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength

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

  describe('#init_rows') do
    it 'initializes rows' do
      dc = described_class.new(DATA)
      dc.send :init_rows

      expect(dc.instance_variable_get(:@rows)).to eq(DATA[1..])
    end

    it 'handles empty sheet' do
      dc = described_class.new([[], [], []])
      dc.send :init_rows

      expect(dc.instance_variable_get(:@rows)).to eq([[], []])
    end
  end

  describe '#convert' do
    it 'converts data' do
      dc = described_class.new(DATA)
      ret = dc.convert

      expect(ret).to eq([
                          { 'Place' => 'Slice Brothers',
                            'Deal' => '2 slices for $5.99',
                            'Deal Earned' => '',
                            'Deal Used' => '03/30/2024',
                            'Deal Starts' => '',
                            'Deal Ends' => '',
                            'Notes' => 'no longer active',
                            'Money Saved' => '4.99',
                            'Reward Type' => 'no longer active' },
                          { 'Place' => 'Slice Brothers',
                            'Deal' => '2 slices for $5.99',
                            'Deal Earned' => '',
                            'Deal Used' => '04/11/2024',
                            'Deal Starts' => '',
                            'Deal Ends' => '',
                            'Notes' => 'no longer active',
                            'Money Saved' => '4.99',
                            'Reward Type' => 'no longer active' },
                          { 'Place' => 'Pot Belly',
                            'Deal' => '1 free sandwich with the purchase of sandwich between 04/01 and 04/07',
                            'Deal Earned' => '04/04/2024',
                            'Deal Used' => '04/08/2024',
                            'Deal Starts' => '04/01/2024',
                            'Deal Ends' => '04/07/2024',
                            'Notes' => '',
                            'Money Saved' => '10.66',
                            'Reward Type' => 'rewards' }
                        ])
    end

    it 'handles empty sheet' do
      dc = described_class.new([[], []])
      ret = dc.convert

      expect(ret).to eq([{}])
    end
  end
end

# rubocop:enable RSpec/ExampleLength
