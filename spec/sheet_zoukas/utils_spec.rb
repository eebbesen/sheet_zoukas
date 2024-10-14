# frozen_string_literal: true

# rubocop:disable RSpec/MultipleExpectations

require 'spec_helper'
require 'sheet_zoukas/utils'

RSpec.describe SheetZoukas::Utils do
  describe '.vars_present?' do
    before { ENV.store('PRESENT_VAR', 'present') }

    it 'returns false when missing vars' do
      expect do
        expect(described_class).not_to be_vars_present(%w[MISSING_VAR PRESENT_VAR], 'is missing')
      end.to output("⛔️ MISSING_VAR is missing.\n").to_stdout
    end

    it 'returns true when no missing vars' do
      expect do
        expect(described_class).to be_vars_present(%w[PRESENT_VAR], 'is missing')
      end.not_to output.to_stdout
    end

    it 'returns false when variable empty string' do
      ENV.store('EMPTY_VAR', '')

      expect do
        expect(described_class).not_to be_vars_present(%w[PRESENT_VAR EMPTY_VAR], 'is missing')
      end.to output("⛔️ EMPTY_VAR is missing.\n").to_stdout
    end

    it 'returns false when variable blank string' do
      ENV.store('EMPTY_VAR', '  ')

      expect do
        expect(described_class).not_to be_vars_present(%w[PRESENT_VAR EMPTY_VAR], 'is missing')
      end.to output("⛔️ EMPTY_VAR is missing.\n").to_stdout
    end
  end
end

# rubocop:enable RSpec/MultipleExpectations
