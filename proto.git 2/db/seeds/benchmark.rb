# encoding: UTF-8

ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE `#{table}`") unless %w[schema_migrations].include? table
end

require 'factory_girl'

random_text = [
  '彼らのためにお願いします。世のためではなく、わたしに与えてくださった人々のためにお願いします。彼らはあなたのものだからです。',
  'わたしのものはすべてあなたのもの、あなたのものはわたしのものです。わたしは彼らによって栄光を受けました。',
  'わたしは、もはや世にはいません。彼らは世に残りますが、わたしはみもとに参ります。聖なる父よ、わたしに与えてくださった御名によって彼らを守ってください。わたしたちのように、彼らも一つとなるためです。',
  'わたしは彼らと一緒にいる間、あなたが与えてくださった御名によって彼らを守りました。わたしが保護したので、滅びの子のほかは、だれも滅びませんでした。聖書が実現するためです。',
  'さて、使徒たちは集まって、「主よ、イスラエルのために国を建て直してくださるのは、この時ですか」と尋ねた。',
  'イエスは言われた。「父が御自分の権威をもってお定めになった時や時期は、あなたがたの知るところではない。',
  'あなたがたの上に聖霊が降ると、あなたがたは力を受ける。そして、エルサレムばかりでなく、ユダヤとサマリアの全土で、また、地の果てに至るまで、わたしの証人となる。」',
  'こう話し終わると、イエスは彼らが見ているうちに天に上げられたが、雲に覆われて彼らの目から見えなくなった。'
]

# Add body parts
require Rails.root.join('db', 'seeds', 'production', 'body_parts' )
require Rails.root.join('db', 'seeds', 'production', 'tag_groups' )

# Add stamps
require Rails.root.join('db', 'seeds', 'production', 'stamps' )

SIZE = ENV['SIZE'].to_i || 1

SIZE.times do |i|
  puts ("="*32)+"\nChunk : #{i+1}\n"+("-"*32)

  users = FactoryGirl.build_list :user, 100
  users.each { |user| user.bio = random_text.sample }
  User.import users, validate: false
  puts "Insert Users: #{users.length}"
  user_max_id = User.count

  brands = FactoryGirl.build_list(:brand, 10).map do |r|
    r.description = random_text.sample
    r
  end
  Brand.import brands, validate: false
  puts "Insert Brands: #{brands.length}"
  brand_max_id = Brand.count

  makers = FactoryGirl.build_list(:maker, 10).map do |r|
    r.description = random_text.sample
    r
  end
  Maker.import makers, validate: false
  puts "Insert Makers: #{makers.length}"
  maker_max_id = Maker.count

  products = FactoryGirl.build_list(:product, 100).map do |r|
    r.description = random_text.sample
    r.brand_id = Random.rand(brand_max_id)+1
    r.maker_id = Random.rand(maker_max_id)+1
    r
  end
  Product.import products, validate: false
  puts "Insert Products: #{products.length}"
  product_max_id = Product.count

  reports = FactoryGirl.build_list(:report, 200).map do |r|
    r.body = random_text.sample
    r.writer_id = Random.rand(user_max_id)+1
    r.product_id = Random.rand(product_max_id)+1
    r
  end
  Report.import reports, validate: false
  puts "Insert Reports: #{reports.length}"

  questions = FactoryGirl.build_list(:question, 200).map do |r|
    r.body = random_text.sample
    r.writer_id = Random.rand(user_max_id)+1
    r.product_id = Random.rand(product_max_id)+1
    r
  end
  Question.import questions, validate: false
  puts "Insert Questions: #{questions.length}"

  puts "\n"
end
