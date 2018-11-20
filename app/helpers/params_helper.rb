module ParamsHelper

  def trim_params(params)
    params.each { |_, val| val.strip! if val.respond_to?(:strip!) }
  end

end
