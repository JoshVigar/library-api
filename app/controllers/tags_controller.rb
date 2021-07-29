# frozen_string_literal: true

class TagsController < ApplicationController
  PERMITTED_CREATE_PARAMETERS = %i[name].freeze
  private_constant :PERMITTED_CREATE_PARAMETERS

  def index
    render json: TagSerializer.serialize(tags_index)
  end

  def create
    if tag_create.valid?
      render json: TagSerializer.new(tag_create), status: :created
    else
      render json: error(tag_create.errors.messages), status: :bad_request
    end
  end

  private

  def tags_index
    if book
      book.tags
    else
      Tag.all
    end
  end

  def tag_create
    tag = Tag.create(validated_create_params)
    book.tags << tag if tag.valid? && book
    @tag_create ||= tag
  end

  def validated_create_params
    @validated_create_params ||= params.require(:data)
                                       .require(%i[type attributes])[1]
                                       .permit(PERMITTED_CREATE_PARAMETERS).to_h
  end

  def book
    @book ||= Book.find_by(id: params[:book_id])
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
