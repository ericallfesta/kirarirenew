class ReportEvaluation < ActiveRecord::Base
  belongs_to :report
  belongs_to :evaluation
end
