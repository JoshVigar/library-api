# frozen_string_literal: true

class BooksController < ApplicationController
  PERMITTED_FILTERS = %i[title].freeze

  def index
    render json: BookSerializer.new(book_index)
  end

  def book_index
    return Book.all if params[:filter].blank?

    Book.where(validated_filter_params)
  end

  def validated_filter_params
    filters = params[:filter]
    filters.permit(PERMITTED_FILTERS)
  end
end
