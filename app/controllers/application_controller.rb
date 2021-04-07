class ApplicationController < ActionController::API
  include ActionController::Helpers
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record

  def render_404
    render json: exception.record.errors, status: 404
  end

  def render_invalid_record
    render json: "Invalid Record", status: :not_found
  end
end
