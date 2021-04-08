# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :validate_content_type_header, :validate_accept_header

  private

  def validate_content_type_header
    render(status: 406, body: nil) unless Validators::JsonapiHeaders.validate_content_type(request.headers)
  end

  def validate_accept_header
    render(status: 415, body: nil) unless Validators::JsonapiHeaders.validate_accept(request.headers)
  end
end
