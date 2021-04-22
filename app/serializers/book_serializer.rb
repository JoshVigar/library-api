# frozen_string_literal: true

class BookSerializer
  include JSONAPI::Serializer

  attributes :title, :author, :description
  has_many :reviews

  class << self
    def serialize(relation, options = default_options)
      new(relation, options).serializable_hash.to_json
    end

    private

    def default_options
      { include: %i[reviews] }
    end
  end
end
