class Api::V1::BaseController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    return api_error(status: 404, errors: "Not found")
  end
end