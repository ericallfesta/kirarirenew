module ColumnsHelper
  def column_categories
    [:beauty, :health]
  end
  alias :column_substances :column_categories

  def column_substance_path substance
    raise "invalid substance" unless column_substances.include? substance.to_sym
    "/columns/#{substance}"
  end
end
