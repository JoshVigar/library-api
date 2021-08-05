# frozen_string_literal: true

class Video < ApplicationRecord
  include Streamable

  validates :duration, presence: true
end
