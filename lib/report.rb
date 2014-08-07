

class Report

  @sum = ->(a,b) { a + b }

  def self.summarize(input)
    { search: input.map { |i| if (i[:event] == :search) then 1 else 0 end }.reduce(&@sum) }
  end
end
