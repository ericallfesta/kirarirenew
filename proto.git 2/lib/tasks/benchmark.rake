require 'benchmark'

namespace :benchmark do
  task all: :environment do
    Rake::Task['benchmark:search'].invoke
    Rake::Task['benchmark:recommend_user'].invoke
  end

  task search: :environment do
    puts "="*32+"\nbenchmark:search\n"+'-'*32
    q = ENV['Q'] || 'sample'
    Benchmark.bm do |x|
      x.report('p') { Product.search( q: q ).each {} }
      x.report('r') { Report.search( q: q ).each {} }
      x.report('q') { Report.search( q: q ).each {} }
    end
  end

  task recommend_user: :environment do
    puts "="*32+"\nbenchmark:recommend_user\n"+'-'*32
    Benchmark.bm do |x|
      10.times do
        user = User.order('RAND()').first
        x.report(user.id) { user.recommend_users(limit: 10).each {} }
      end
    end
  end
end
