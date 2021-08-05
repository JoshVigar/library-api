# frozen_string_literal: true

FactoryBot.define do
  factory :podcast do
    episodes { 1 }
    episode_length { 100 }
  end
end
