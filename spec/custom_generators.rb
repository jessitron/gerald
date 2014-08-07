require_relative 'generators'
require 'rantly'

class CustomGenerators
  class << self

    def rantly
      Rantly.singleton
    end
    def activity_record(events=[:search, :click])
      Generator.new( ->(){ { event: rantly.choose(*events), userid: userid.sample } } ).not_shrinkable
    end
    def activity_record_for(event)
      activity_record([event])
    end
    def userid
      Generator.new( ->() { rantly.string })
    end
  end
end
