require_relative 'gerald'

class Report


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

    def sum; ->(a,b) { a + b } end

    def event_count_gerald(event)
      Gerald.new(#the abelian group is Int
        ->(input) { count_if_eq(event).call(input[:event]) },
        sum,
        0,
        ->(output, count) { output.merge( {event => count} )},
        event.to_s
      )
    end

    def different_users_gerald
      Gerald.new( #the abelian group is Set
        ->(input) { Set.new [input[:userid]]},
        ->(s1,s2) { s1.merge(s2)},
        Set.new,
        ->(output,s) { output.merge({different_users: s.size})},
                "unique-users")
    end

    def summarize(input)
      event_geralds = [:search, :click].map{|e| event_count_gerald(e)}
      output = Gerald.combine(event_geralds.push different_users_gerald).process(input, {})

      output
    end
  end
end
