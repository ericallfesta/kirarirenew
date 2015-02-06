class ReportEfficacy < ActiveRecord::Base
  belongs_to :report
  belongs_to :efficacy

  validates_presence_of :report, :efficacy
end
