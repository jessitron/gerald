require_relative 'gerald'

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

    def different_users_gerald
      Gerald.new(
        ->(input) { Set.new [input[:userid]]},
        ->(s1,s2) { s1.merge(s2)},
        Set.new,
        ->(output,s) { output.merge({different_users: s.size})})
    end

    def summarize(input)
      defaults = {search: 0, click: 0, different_users: 0}
      unique_events = input.map(&get(:event)).uniq
      output = unique_events.inject(defaults){ |m, event| m.merge({event => count_event(event, input)}) }
      different_users_gerald.process(input, output)
    end
  end
end
