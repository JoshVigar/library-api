# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  it { is_expected.to belong_to(:book) }

  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_numericality_of(:rating).only_integer }
  it { is_expected.to validate_inclusion_of(:rating).in_range(0..5) }

  it { is_expected.to validate_presence_of(:user_name) }
  it { is_expected.to validate_length_of(:user_name).is_at_least(3) }
end
