# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  it { is_expected.to validate_presence_of(:duration) }

  it_behaves_like 'streamable'
end
