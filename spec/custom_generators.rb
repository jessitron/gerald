require_relative 'generators'
require 'rantly'

class CustomGenerators
  class << self

    def rantly
      Rantly.singleton
    end
    def activity_record(events=[:search, :click])
      Generator.new( ->(){ { event: rantly.choose(*events) } } ).not_shrinkable
    end
    def activity_record_for(event)
      activity_record([event])
    end
  end
end
