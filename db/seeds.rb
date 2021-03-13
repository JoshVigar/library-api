puts '======> Destroying existing records'

ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("DELETE from #{table}")
end

puts '======> Seeding books'

Faker::UniqueGenerator.clear
FactoryBot.create_list(:book, 10)

puts '======> Finished Seeding Books'
