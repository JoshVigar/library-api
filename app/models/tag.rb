# frozen_string_literal: true

class Tag < ApplicationRecord
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :books
  # rubocop:enable Rails/HasAndBelongsToMany
  validates :name, uniqueness: true
end
