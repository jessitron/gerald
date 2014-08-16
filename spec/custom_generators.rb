require 'generatron'

class CustomGenerators
  class << self

    def rantly
      Rantly.singleton
    end
    def activity_record(events=[:search, :click])
      user_gen = userid
      Generator.new( ->(){ { event: rantly.choose(*events), userid: user_gen.sample } } ).not_shrinkable
    end
    def activity_record_for(event)
      activity_record([event])
    end
    def userid(max_unique=20)
      unique_users = (1..max_unique).map {|x| rantly.string}
      Generator.new( ->() { rantly.choose(*unique_users) })
    end
  end
end
