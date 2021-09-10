# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rating { 1 }
    comment { 'A review of a book' }
    user_name { 'username' }
    book { nil }
  end
end
