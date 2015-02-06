namespace :body_map do
  desc "Regenerate body map"
  task regenerate: :environment do
    ActiveRecord::Base.connection.execute "TRUNCATE `body_parts`"
    require Rails.root.join('db/seeds/production/body_parts.rb')
  end
end
