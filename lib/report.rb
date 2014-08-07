

class Report

  @sum = ->(a,b) { a + b }

  class << self
    def get(field)
       ->(m) { m[field]}
    end

    def count_if_eq(value)
       ->(test) { if (test == value) then 1 else 0 end }
    end

    def count_event(event, input)
      input.map(&get(:event)).map(&count_if_eq(:search)).reduce(&@sum)
    end

    def summarize(input)
      unique_events = input.map(&get(:event)).uniq
      puts unique_events
      unique_events.inject({}){ |m, event| m.merge({event => count_event(event, input)}) }
    end
  end
end
