# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    render json: Book.all.map(&:title)
  end
end
