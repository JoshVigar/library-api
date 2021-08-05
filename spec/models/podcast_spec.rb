# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Podcast, type: :model do
  it { is_expected.to validate_presence_of(:episodes) }
  it { is_expected.to validate_presence_of(:episode_length) }

  it_behaves_like 'streamable'
end
