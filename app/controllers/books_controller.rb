# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    titles = Book.all.map(&:title)
    render plain: titles
  end
end
