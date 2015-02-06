class BodyPart < ActiveRecord::Base
  has_many :body_part_tags
  has_many :tags, through: :body_part_tags

  validates :name, presence: true, length: { in: 1..24 }
  validates :slug, presence: true,
                   format: { with: /\A[0-9A-Za-z]/ },
                   length: { in: 2..24 },
                   uniqueness: true

  class << self
    def grouped(groups)
      @all = self.includes(:tags)
      groups = [groups] unless groups.is_a? Array
      @all.select { |r| groups.map(&:to_s).include? r.group_code }
    end
  end

  def empty?
    self.tags_count <= 0 || ( self.tags.inject(0) { |sum, t| sum += t.products_count } ) <= 0
  end
end
