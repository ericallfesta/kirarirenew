class User < ActiveRecord::Base
  include Favorable

  authenticates_with_sorcery!

  has_many :writings, foreign_key: :writer_id
  has_many :diaries, foreign_key: :writer_id
  has_many :reports, foreign_key: :writer_id
  has_many :questions, foreign_key: :writer_id
  has_many :comments, after_add: :get_write_comment_for_stamp
  has_many :favs, class_name: 'Favorite', foreign_key: :user_id
  has_many :favorites, as: :favorable
  has_many :favorite_users, through: :favorites, source: :user
  has_many :follows
  has_many :followed_users, -> { where "follows.followable_type" => 'User' },
                            through: :follows,
                            source: :followed_user
  has_many :followed_brands, -> { where "follows.followable_type" => 'Brand' },
                             through: :follows,
                             source: :followed_brand
  has_many :followables, class_name: 'Follow', as: :followable
  has_many :followers, class_name: 'User', foreign_key: :user_id, through: :followables, source: :user
  has_many :notifications
  has_many :user_stamps
  has_many :stamps, through: :user_stamps, after_add: :add_point
  belongs_to :brand

  RANGE_POLICY = %w[public private].freeze
  ROLES = %w[general admin enterprise guest].freeze

  validates :password, presence: true, confirmation: :password, length: { minimum: 6 }, allow_blank: true, on: :create
  validates :display_name, presence: true, length: 1..28
  validates :email, presence: true, uniqueness: true, email: true, allow_blank: true
  validates :role, inclusion: { in: ROLES }, if: :role
  validates :range_policy, inclusion: { in: RANGE_POLICY }, if: :range_policy
  validates :gender, presence: true, inclusion: { in: %w(male female other) }
  validates_acceptance_of :terms, allow_nil: false, on: :create

  after_create :get_stamp_register_kirari
  after_save :get_stamp_write_profile

  default_scope { order created_at: :asc }

  default_value_for :role, 'general'
  default_value_for :range_policy, 'public'

  mount_uploader :image, UserUploader

  ranking_with :point

  ROLES.each do |r|
    define_method "is_#{r}?" do
      role.to_s == __method__.to_s.gsub(/\Ais_([a-z]+)\?\z/, '\1')
    end
  end

  def role=(value)
    super(value.to_s)
  end

  def range_policy=(value)
    super(value.to_s)
  end

  def age
    birthday.present? ? (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i ) / 10000 : nil
  end

  def fav target
    target.favorites.create(user: self) unless favorited? target
  end

  def unfav target
    favs.where(favorable_type: target.class.to_s, favorable_id: target.id).first.destroy if favorited? target
  end

  def favorited? target
    favs.where(favorable_type: target.class.to_s).pluck(:favorable_id).include? target.id
  end

  def followees
    self.followed_users + self.followed_brands
  end

  def follow target
    self.follows.create followable: target unless follow? target
  end

  def follow? target
    follows.where(followable_type: target.class.to_s, followable_id: target.id).count > 0
  end

  ALLOWED_ACTIVITY_TYPES = %w[all writing diary question report].freeze

  def activities(activity_type = :all)
    raise "Invalid activity type" unless ALLOWED_ACTIVITY_TYPES.include? activity_type.to_s
    klass = (activity_type == :all ? :writing : activity_type).to_s.classify.constantize
    klass.where(writer_id: self.followed_users.pluck(:id) + [id]).includes(:writer, :images, :favorites, product: [:brand, :variations, :tags, :favorites], comments: [:user]).order(commented_at: :desc)
  end

  def notifications_status
    notifications.where( status: 'unread' ).count > 0 ? :unread : :read
  end

  def notifications_count
    notifications.where( status: 'unread' ).count
  end

  def name
    display_name
  end

  def excerpt
    bio.to_s
  end

  def add_point(stamp)
    self.point += stamp.point
    self.save
  end

  def unacquired_stamps
    Stamp.all.inject([]) {|r, s| r += self.stamps.include?(s) ? [] : [s] }
  end

  def favorites_total
    [
      Favorite.where('favorable_type', %w(Diary Report Question Writing)).where('favorable_id', self.writings.pluck(:id)).count,
      self.favorites.count
    ].sum
  end

  def to_meta(options={})
    MetaControl.create self, { title: self.display_name, description: :excerpt }.merge(options)
  end

  def recommend_users limit: 4
    users = self.class
      .where(invisible: false)
      .where.not(id: [self.id] + self.followed_users.pluck(:id))
      .order(point: :desc)
      .includes([:followers, :followed_users, :reports, :questions, :diaries, :followed_brands, :favorites])
    users.take(10).sample limit
  end

  def self.recommend_users limit: 4
    users = where(invisible: false)
      .order(point: :desc)
      .includes([:followers, :followed_users, :reports, :questions, :diaries, :followed_brands, :favorites])
    users.take(10).sample limit
  end

  def self.top(length=3)
    ranking = self.point_ranking
    ranking.per_page = length
    ranking.page 1
  end

  private

  def get_stamp_register_kirari
    stamp = Stamp.find_by slug: 'register_kirari'
    self.stamps << stamp if stamp.present? && ! stamps.include?(stamp)
  end

  def get_stamp_write_profile
    stamp = Stamp.find_by slug: 'write_profile'
    return if self.bio.blank? || ! self.image? || self.birthday.blank?
    self.stamps << stamp if stamp.present? && ! stamps.include?(stamp)
  end

  def get_write_comment_for_stamp comment
    comment.writing.get_write_comment_for_stamp comment
  end
end
