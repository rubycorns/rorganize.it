module ParamsHelper
  extend ActiveSupport::Concern

  def trim_params
    puts "\n\n\n\n\nYOOOOOOOOO\n\n\n\n\n"
    params.each { |_, val| val.strip! if val.respond_to?(:strip!) }   end
end
