ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE `#{table}`") unless %w[schema_migrations].include? table
end

require 'factory_girl'

# Add body parts
require Rails.root.join('db', 'seeds', 'production', 'body_parts' )
require Rails.root.join('db', 'seeds', 'production', 'tag_groups' )

# Add stamps
require Rails.root.join('db', 'seeds', 'production', 'stamps' )

# Add development user
User.create(username: "admin", display_name: "Admin", email: "kirari@clustium.com", password: 'secret', password_confirmation: 'secret', bio: 'biography '*20, birthday: Date.new(1988,8,5), range_policy: 'public', role: 'admin', terms: '1', gender: 'male')

FactoryGirl.create_list :user, 80, terms: '1', gender: 'male'

FactoryGirl.create_list :serial, 10, :any_writer, columns_number: 10

FactoryGirl.create_list :brand, 20, products_number: 20

FactoryGirl.create_list :report, 200, :any_product, :any_writer
FactoryGirl.create_list :question, 200, :any_product, :any_writer
FactoryGirl.create_list :diary, 200, :any_writer

Product.all.each { |product| product.update_star; product.save }
