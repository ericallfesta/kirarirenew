class SearchKeyword
  class << self
    def instance
      @instance ||= SearchKeyword.new
    end

    def list_name date = nil
      date = Date.today if date.nil?
      "search:keywords:#{date.strftime("%Y%m%d")}"
    end
  end

  def push args = {}
    redis.lpush( self.class.list_name, args[:face] )
  end

  def range date, range = 100
    redis.lrange(self.class.list_name(date), 0, range)
  end

  def today range = 100
    range Date.today, range
  end

  def yesterday range = 100
    range Date.today.prev_day(1), range
  end
end
