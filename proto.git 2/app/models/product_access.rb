class ProductAccess
  def initialize(product, date = nil)
    @date = "#{Date.today.strftime('%Y%m%d')}"
    @product = product
    @score = redis.zscore(key, @product.id) unless @product.id.nil?
    @score = 0 if @score.nil?
  end

  def gain
    self.score = self.score + 1
  end

  def score
    @score ||= 0
  end

  def score=(value)
    redis.zadd(key, value, @product.id) unless @product.id.nil?
    @score = value
  end

  KEY_PREFIX = "product:access:"

  def key
    "#{KEY_PREFIX}#{@date}"
  end

  def self.today_key
    "#{KEY_PREFIX}#{Date.today.strftime('%Y%m%d')}"
  end
end
