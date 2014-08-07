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

  it 'counts unique users' do
    various_numbers_of_users = []
    property_of {
      Generators.any_number_of(
         CustomGenerators.activity_record).sample
    }.check { |input|
      unique_users = input.map{|m| m[:userid]}.reject{|u|u.nil?}.uniq.size

      # this is for checking on whether the test is accomplishing anything
      various_numbers_of_users.push([unique_users, input.size])
      actual = Report.summarize(input)
      expect(actual[:different_users]).to eq(unique_users)
    }
    puts "Saw these user counts: #{various_numbers_of_users}"
  end
end
