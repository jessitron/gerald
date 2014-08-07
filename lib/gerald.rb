
class Gerald
  # how do I make these accessible to other Geralds but not outside?
  @to_ag
  @append
  @zero
  @from_ag
  @name

  attr_accessor :to_ag, :append, :zero, :from_ag, :name
  def to_s; "#{@name}" end

  def initialize(transform_in, append_op, zero, build_output, name="Gerald")
    @to_ag=transform_in
    @append=append_op
    @zero=zero
    @from_ag=build_output
    @name=name
  end

  def process(input, empty_output)
    ags = input.map(&@to_ag)
   # puts "#{name} has ags #{ags}"
    summary = ags.reduce(@zero,&@append)
   # puts "#{name} has summary #{summary}"
    output = @from_ag.call(empty_output, summary)
   # puts "#{name} has output #{output}"
    output
  end

  def self.combine(geralds)
    transforms = geralds.map{|g| g.to_ag}
    new_transform = ->(input) {
      transforms.map{ |t| t.call(input)}
    }

    new_append = ->(seq_of_ags1, seq_of_ags2) {
      geralds.zip(seq_of_ags1, seq_of_ags2).map do |(g, a1, a2)|
        g.append.call(a1,a2)
      end
    }

    zeros = geralds.map{|g| g.zero}

    output_builders = geralds.map{|g| g.from_ag}
    new_builder = ->(input, seq_of_ags) {
      output_builders.zip(seq_of_ags).reduce(input) { |acc, (f, ag)|
        f.call(acc, ag)
      }
    }

    name = "[#{geralds.map{|g|g.name}.join(",")}]"

    Gerald.new(new_transform, new_append, zeros, new_builder, name)
  end
end
