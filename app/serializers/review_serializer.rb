# frozen_string_literal: true

class ReviewSerializer
  include JSONAPI::Serializer

  attributes :rating, :comment, :user_name
  belongs_to :book
end
