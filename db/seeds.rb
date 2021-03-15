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

puts '======> Finished Seeding Books'
