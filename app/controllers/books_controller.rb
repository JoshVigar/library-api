# frozen_string_literal: true

class BooksController < ApplicationController
  PERMITTED_FILTERS = %i[title].freeze

  def index
    render json: BookSerializer.new(book_index)
  end

  def create
  end

  private

  def book_index
    return Book.all if validated_filter_params[:filter].blank?

    Book.where(validated_filter_params[:filter])
  end

  def validated_filter_params
    @validated_filter_params ||= Validators::Books::Index.validate!(params)
  end
end
