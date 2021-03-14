puts '======> Destroying existing records'

ActiveRecord::Base.connection.tables.each do |table|
  unless table = 'ar_internal_metadata' || table = 'schema_migrations'
    ActiveRecord::Base.connection.execute("DELETE from #{table}")
    ActiveRecord::Base.connection.reset_pk_sequence! table
  end
end

puts '======> Seeding books'

Faker::UniqueGenerator.clear
FactoryBot.create_list(:book, 10)

puts '======> Finished Seeding Books'
