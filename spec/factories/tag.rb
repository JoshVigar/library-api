# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { Faker::Book.unique.genre }
  end
end
