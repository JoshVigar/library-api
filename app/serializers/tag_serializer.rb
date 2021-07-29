# frozen_string_literal: true

class TagSerializer
  include JSONAPI::Serializer

  attributes :name
  has_many :books

  class << self
    def serialize(relation, options = default_options)
      new(relation, options).serializable_hash.to_json
    end

    private

    def default_options
      { include: %i[books] }
    end
  end
end
