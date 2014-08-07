require 'rantly'
require_relative 'shrinkers'

class Generator
  def initialize(how_to_produce)
    @produce = how_to_produce
  end

  def not_shrinkable
    Generator.new(->() { Shrinkers.do_not_shrink(sample)})
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

    def const(value)
      Generator.new(->{value})
    end

    def some_array_len(max=100)
      # this won't work with max < 2
      # I want this to emphasize smaller numbers. maybe later.

      Generator.new( ->() {
        rantly.freq([10, ->(r) {0}],
                    [10, ->(r) {1}],
                    [5,  ->(r) {2}],
                    [75, ->(r) {r.range(0,max)} ])} )
    end

    def rantly; Rantly.singleton end

  end
end
