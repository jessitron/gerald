require_relative '../lib/report'
require_relative 'spec_helper'

describe Report do

  it 'counts search events' do
    input = [{ event: :search },
             { event: :not_search  },
             { event: :search}]
    actual = Report.summarize(input)
    expected = { search: 2 }
    expect(actual).to eq(expected)
  end
end
