# frozen_string_literal: true

RSpec.describe SheetZoukas do
  it 'has a version number' do
    expect(SheetZoukas::VERSION).not_to be_nil
  end

  describe '.retrieve_sheet_json' do
    before { ENV.store('GOOGLE_API_SPREADSHEET_ID_TEST', 'test_id') }

    it 'retrieves sheet data' do # rubocop:disable RSpec/ExampleLength
      VCR.use_cassette('retrieve_sheet_json') do
        data = described_class.retrieve_sheet_json(ENV.fetch('GOOGLE_API_SPREADSHEET_ID_TEST', nil), 'Log')
        expect(data[0]).to eq('Place' => 'Slice Brothers',
                              'Deal' => '2 slices for $5.99',
                              'Deal Earned' => '',
                              'Deal Used' => '03/30',
                              'Deal Starts' => '',
                              'Deal Ends' => '',
                              'Notes' => 'no longer active',
                              'Money Saved' => '4.99',
                              'Reward Type' => 'no longer active')
      end
    end

    it 'fails when missing required environment variable' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
      missing = SheetZoukas::REQUIRED_VARS.first
      ENV.delete(missing)
      expect do
        expect do
          described_class.retrieve_sheet_json(ENV.fetch('GOOGLE_API_SPREADSHEET_ID_TEST', nil), 'Log')
        end.to raise_error(SystemExit) do |error| # rubocop:disable Style/MultilineBlockChain
          expect(error.status).to eq(1)
        end
      end.to output("⛔️ #{missing} required for Google Sheets API calls.\n").to_stdout
    end
  end
end
