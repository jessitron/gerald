require_relative '../lib/report'
require_relative 'spec_helper'

describe Report do

  it 'counts search events' do
    input = [{ event: :search },
             { event: :not_search  },
             { event: :search}]
    actual = Report.summarize(input)
    expected = { search: 2 }

    def what_matters(r)
      r[:search]
    end
    expect(what_matters(actual)).to eq(what_matters(expected))
  end
end
