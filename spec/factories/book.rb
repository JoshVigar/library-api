# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    author { Faker::Book.author }
    title  { Faker::Book.unique.title }
    description { Faker::Lorem.sentence }
  end
end
