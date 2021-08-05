# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Medium, type: :model do
  it { is_expected.to belong_to(:streamable) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:link) }
end
