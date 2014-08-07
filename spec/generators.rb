require 'rantly'

class Generator
  def initialize(how_to_produce)
    @produce = how_to_produce
  end

  def sample
    @produce.call
  end

  def sampleN(n)
    (1..n).map{ |x| sample}
  end

  def filter(predicate)
    inner = self
    Generator.new -> do
      r = nil
      begin
        r = inner.sample
      end until predicate.(r)
      # consider using rantly.guard instead of looping
      r
    end
  end
end


module Generators
  class << self

    def of_two(gen1, gen2)
      Generator.new( ->() {
        r = [gen1.sample, gen2.sample]
        Shrinkers.shrink_like_i_say(r)
      })
    end

    def any_number_of(inner)
      Generator.new( ->() {
        inner.sampleN(some_array_len.sample)
      })
    end

    def some_array_len(max=100)
      # I want this to emphasize smaller numbers. maybe later.
      Generator.new( ->() {rantly.range(0,max)} )
    end

    def rantly; Rantly.singleton end

  end
end
