namespace :stamps do
  desc "Generate stamps"

  task generate: :environment do
    require Rails.root.join('db', 'seeds', 'production', 'stamps.rb')
  end
end
