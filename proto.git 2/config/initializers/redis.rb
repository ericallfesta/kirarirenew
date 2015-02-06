default = {
  production: {},
  development: {},
  test: {}
}
filepath = "#{Rails.root}/config/redis.yml"
config = default.merge(File.exist?(filepath) ? YAML.load_file(filepath) : {})

Rails.application.config.redis = config[Rails.env.to_sym]

def redis
  Thread.current[:redis] ||= Redis.connect(Rails.application.config.redis)
end
