# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :author, :title, presence: true
  validates :title, uniqueness: true

  scope :title, ->(title) { where(title: title) }
end
