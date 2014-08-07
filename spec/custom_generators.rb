require_relative 'generators'
require 'rantly'

class CustomGenerators
  class << self
    @valid_events = [:search, :click]

    def rantly
      Rantly.singleton
    end
    def activity_record
      Generator.new ( ->(){ { event: rantly.choose(@valid_events) } } )
    end
  end
end
