namespace :helper do
  desc "Build reports and questions of the product each users"
  task :large_product, [:product_id] => [:environment] do |t, args|
    product_id = args[:product_id]
    product = Product.find(product_id)
    raise "invalid product" unless product

    User.all.each do |user|
      begin
        Question.create!(title: 'empty', body: "しつもんですよ。" * rand(100), writer: user, product: product, star: rand(5))
        Report.create!(title: 'empty', body: "れぽーとですよ。\n" * rand(100), writer: user, product: product, star: rand(5))
      rescue => e
        pp e.inspect
      end
    end
  end

end
