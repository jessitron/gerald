require_relative '../lib/report'
require_relative 'spec_helper'

describe Report do

  it 'counts search events' do
    property_of {
      Generators.of_two(Generators.const(0), #Generators.some_array_len,
       Generators.any_number_of(
         CustomGenerators.activity_record.filter(->(a) {a[:event] != :search}))).sample
    }.check do |(search_count, other_events)|
      search_events = CustomGenerators.activity_record_for(:search).sampleN(search_count)
      input = search_events + other_events
      actual = Report.summarize(input)

      expect(actual[:search]).to eq(search_count)

    end
  end
end
