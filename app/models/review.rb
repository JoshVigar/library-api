# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :book, validate: true

  validates :rating, :user_name, presence: true
  validates :rating,
            numericality: { only_integer: true },
            inclusion: { in: 0..5 }
  validates :user_name, length: { minimum: 3 }
end
