class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    if value.is_a?(String)
      Date.parse(value.gsub(/[-.\/]/, '-'))
    elsif ! value.is_a?(Date)
      record.errors.add(attr_name, :invalid_date, options)
    end
  rescue => e
    record.errors.add(attr_name, :invalid_date, options)
  end
end
