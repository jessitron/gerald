

class Report

  @sum = ->(a,b) { a + b }

  class << self
    def get(field)
       ->(m) { m[field]}
    end

    def count_if_eq(value)
       ->(test) { if (test == value) then 1 else 0 end }
    end

    def summarize(input)
      { search: input.map(&get(:event)).map(&count_if_eq(:search)).reduce(&@sum) }
    end
  end
end
