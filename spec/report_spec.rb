require_relative '../lib/report'
require_relative 'spec_helper'

describe Report do

  it 'counts search events' do
    property_of {
      search_event = ->(e) {e[:event] == :search}
      Generators.some_array_len.map(->(search_count) {
        search_events = CustomGenerators.activity_record_for(:search).
                             sample_n(search_count)
        other_events =  Generators.any_number_of(
                          CustomGenerators.activity_record.
                                           reject(search_event)).sample
        Shrinkers.fixed_len_array([search_count, search_events + other_events])
      }).sample
    }.check do |(search_count, all_events)|
      actual = Report.summarize(all_events)
      expect(actual[:search]).to eq(search_count)
    end
  end

  it 'counts unique users' do
    property_of {
      Generators.any_number_of(
         CustomGenerators.activity_record).sample
    }.check { |input|
      unique_users = input.map{|m| m[:userid]}.reject{|u|u.nil?}.uniq.size
      actual = Report.summarize(input)
      expect(actual[:different_users]).to eq(unique_users)
    }
  end
end
