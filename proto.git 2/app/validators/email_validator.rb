class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    record.errors.add(attr_name, :with, options) unless value.to_s =~ /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  end
end
