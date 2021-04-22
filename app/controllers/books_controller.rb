# frozen_string_literal: true

class BooksController < ApplicationController
  PERMITTED_FILTERS = %i[title].freeze
  PERMITTED_CREATE_PARAMETERS = %i[title author description].freeze
  private_constant :PERMITTED_FILTERS
  private_constant :PERMITTED_CREATE_PARAMETERS

  def index
    render json: BookSerializer.serialize(book_index)
  end

  def create
    if book_create.valid?
      render json: BookSerializer.new(book_create), status: :created
    else
      render json: error(book_create.errors.messages), status: :bad_request
    end
  rescue ActionController::ParameterMissing => e
    render json: error(e.message), status: :bad_request
  end

  private

  def book_index
    return Book.includes(:reviews).all if validated_filter_params.blank?

    Book.includes(:reviews).where(validated_filter_params)
  end

  def validated_filter_params
    @validated_filter_params ||=
      Validators::Books::Index.validate!(params)[:filter]
  end

  def book_create
    @book_create ||= Book.create(validated_create_params)
  end

  def validated_create_params
    @validated_create_params ||= params.require(:data)
                                       .require(%i[type attributes])[1]
                                       .permit(PERMITTED_CREATE_PARAMETERS).to_h
  end

  def error(err_msg)
    {
      errors: {
        status: 400,
        message: err_msg
      }
    }
  end
end
