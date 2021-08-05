# frozen_string_literal: true

FactoryBot.define do
  factory :medium do
    title { Faker::Movie.title }
    link { 'https://www.testsite.com/' }
    streamable { create(:video) }
  end
end
