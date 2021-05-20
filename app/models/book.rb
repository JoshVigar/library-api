# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :tags
  # rubocop:enable Rails/HasAndBelongsToMany

  validates :author, :title, presence: true
  validates :title, uniqueness: true

  scope :title, ->(title) { where(title: title) }
end
