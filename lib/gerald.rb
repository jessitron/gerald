
class Gerald
  @to_ag
  @append
  @zero
  @from_ag

  def initialize(transform_in, append_op, zero, build_output)
    @to_ag=transform_in
    @append=append_op
    @zero=zero
    @from_ag=build_output
  end

  def process(input, empty_output)
    summary = input.map(&@to_ag).reduce(@zero,&@append)
    @from_ag.call(empty_output, summary)
  end

end
