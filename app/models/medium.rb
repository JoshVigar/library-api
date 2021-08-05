# frozen_string_literal: true

class Medium < ApplicationRecord
  belongs_to :streamable, polymorphic: true

  validates :title, :link, presence: true
end
