# frozen_string_literal: true

class Podcast < ApplicationRecord
  include Streamable

  validates :episodes, :episode_length, presence: true
end
