require_relative '../lib/report'
require_relative 'spec_helper'

describe Report do

  it 'counts search events' do
    property_of {
       Generators.any_number_of(
         CustomGenerators.activity_record.filter(->(a) {a[:event] != :search})).sample
    }.check do |other_events|
      input = [{ event: :search },
               { event: :search}] + other_events
      actual = Report.summarize(input)
      expected = { search: 2 }

      def what_matters(r)
        r[:search]
      end
      expect(what_matters(actual)).to eq(what_matters(expected))

    end
  end
end
