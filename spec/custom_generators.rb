require_relative 'generators'
require 'rantly'

class CustomGenerators
  class << self
    @valid_events = [:search, :click]

    def rantly
      Rantly.singleton
    end
    def activity_record
      Generator.new( ->(){ { event: rantly.choose(@valid_events) } } ).not_shrinkable
    end
    def activity_record_for(event)
      Generator.new( ->() {{event: event}}).not_shrinkable
    end
  end
end
