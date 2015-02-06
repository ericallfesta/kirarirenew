namespace :ranking do
  desc "TODO"
  task total: :environment do
    Product.score_ranking.aggregate!
    User.point_ranking.aggregate!
    Product.score_ranking.ranged(:yesterday).aggregate!
    User.point_ranking.ranged(:yesterday).aggregate!
    Tag.where( group: TagGroup.category ).each do |tag|
      ranking = Product.score_ranking.in(tag)
      ranking.aggregate!
    end
  end

  task init: :environment do
    30.times do |i|
      Product.access_ranking(Date.today - i.days).aggregate!
      Product.score_ranking(Date.today - i.days).aggregate!
      User.point_ranking(Date.today - i.days).aggregate!
      puts "Aggregate for #{i} days ago."
    end
  end
end
