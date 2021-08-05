# frozen_string_literal: true

module Streamable
  extend ActiveSupport::Concern

  included do
    has_one :medium, as: :streamable, dependent: :destroy
  end
end
