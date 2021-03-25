# frozen_string_literal: true

class Book < ApplicationRecord
  validates :author, :title, presence: true
  validates :title, uniqueness: true

  scope :title, ->(title) { where(title: title) }
end
