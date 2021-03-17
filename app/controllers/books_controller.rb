# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    render json: BookSerializer.new(Book.all)
  end
end
