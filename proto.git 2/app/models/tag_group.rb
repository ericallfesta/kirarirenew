class TagGroup < ActiveRecord::Base
  has_many :tags, foreign_key: :group_id

  validates_presence_of :name, :slug
  validates_length_of :name, in: 2..32
  validates :slug, length: { in: 4..32 }, format: { with: /\A[a-z_]+\z/ }

  %i(category symptom purpose target nature).each do |s|
    scope s, -> { find_by slug: s.to_s }

    define_method "is_#{s}?" do
      slug.to_s == __method__.to_s.gsub(/\Ais\_([a-z]+)\?\z/, '\1')
    end
  end
end
