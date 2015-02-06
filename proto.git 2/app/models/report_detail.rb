class ReportDetail < ActiveRecord::Base
  belongs_to :report


  BOUGHT_PLACES = %w(department_store drug_store specialist_shop convenience_store net_store call_sale salon tester)
  USE_TIMES = %w(every_day)

  validates_inclusion_of :bought_place, in: self::BOUGHT_PLACES
  validates_inclusion_of :use_times, in: self::USE_TIMES
end
