env = ENV['SEED_ENV'] || Rails.env
require Rails.root.join('db', 'seeds', "#{env}.rb")
