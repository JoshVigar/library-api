# frozen_string_literal: true

class BookSerializer
  include JSONAPI::Serializer

  attributes :title, :author, :description
end
