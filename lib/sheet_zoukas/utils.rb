# frozen_string_literal: true

module SheetZoukas
  # Utility methods
  class Utils
    def self.vars_present?(required_vars, message)
      all_present = true
      required_vars.each do |var|
        if ENV.fetch(var, '').strip.empty?
          all_present = false
          puts "⛔️ #{var} #{message}."
        end
      end
      all_present
    end
  end
end
