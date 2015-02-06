class Column < ActiveRecord::Base
  include Search

  belongs_to :serial
  belongs_to :writer, class_name: 'User'

  SUBSTANCES = %i(beauty health).freeze
  STATUSES = %i(publish waiting).freeze

  validates_presence_of :title, :body, :writer, :published_at, :status
  validates_inclusion_of :substance, in: self::SUBSTANCES.map {|v| v.to_s }
  validates_inclusion_of :status, in: self::STATUSES.map {|v| v.to_s }
  validates_format_of :canonical_url, with: URI::regexp(%w(http https)), allow_blank: true
  validates_length_of :title, in: 4..64

  default_scope -> { order published_at: :desc }
  scope :recently, -> { order published_at: :desc }
  scope :substanced, -> (substance) { where(substance: substance.to_s).order(created_at: :desc) }
  scope :published, -> { where{ status.eq('publish') & (published_at.eq(nil) | published_at.lt(Time.now)) } }
  scope :waiting, -> { where status: 'waiting' }
  scope :pickup, -> { limit 10 }

  mount_uploader :image, ColumnUploader

  def link
    [serial, self]
  end
end
