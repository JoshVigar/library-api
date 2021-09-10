# frozen_string_literal: true

puts '======> Destroying existing records'

ActiveRecord::Base.connection.tables.each do |table|
  unless %w[ar_internal_metadata schema_migrations].include? table
    ActiveRecord::Base.connection.execute("DELETE from #{table}")
  end
end

puts '======> Seeding books'

Faker::UniqueGenerator.clear
FactoryBot.create_list(:book, 10)

puts '======> Seeding tags'

FactoryBot.create_list(:tag, 10) do |tag, i|
  Book.all.sample(i <= 1 ? 10 : 2).map do |book|
    book.tags << tag
    book.save
  end
end

puts '======> Seeding videos'

FactoryBot.create_list(:video, 3)

puts '======> Seeding podcasts'

FactoryBot.create_list(:podcast, 3)

puts '======> Finished Seeding'
