module Search
  extend ActiveSupport::Concern

  included do
    def self.search words
      return self if words.blank? || words.class == 'Array'
      w = words.map{|w| "%#{w}%" }
      columns = self.search_columns.presence || [:name, :description, :title, :body].select{|v| self.column_names.include? v.to_s }
      where [columns.map{|v| [" #{v} LIKE ? "].*(w.size).join(' OR ') }.join(' OR '), *(w * columns.size)]
    end

    def self.search_columns
    end
  end
end
