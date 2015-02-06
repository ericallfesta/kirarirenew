class Report < Writing
  include Star

  has_one :detail, class_name: ReportDetail
  has_many :report_evaluations
  has_many :report_efficacies
  has_many :evaluations, through: :report_evaluations
  has_many :efficacies, through: :report_efficacies

  validates_presence_of :product, :title
  validates_length_of :title, in: 2..64
  validates_inclusion_of :star, in: 0..5, allow_blank: true
  validates_length_of :evaluations, maximum: 5

  after_save :update_star
  after_save :get_write_report_stamp

  accepts_nested_attributes_for :detail
  accepts_nested_attributes_for :report_evaluations, reject_if: :all_blank

  scope :published, -> { includes(:product).where(:"products.state" => 'published') }

  EVALUATIONS_LIMIT = 5

  def build_evaluations
    return [] if product.nil? or product.category.blank?
    self.product.evaluations.order(:priority).each do |e|
      break if report_evaluations.length >= self.class::EVALUATIONS_LIMIT
      next if report_evaluations.include? e
      self.report_evaluations.build evaluation: e
    end
  end

  def selectable_efficacies
    product.category.try(:efficacies) || []
  end

  def update_star
    self.product.update_star
    self.product.save
  end

  def has_thumbnail?
    true
  end

  def thumbnail
    product.image
  end

  def caption
    product.name
  end

  def to_meta
    MetaControl.create self, description: product.description
  end

  private

  def get_write_report_stamp
    stamp = Stamp.find_by slug: 'write_report'
    self.writer.stamps << stamp if stamp.present? && ! self.writer.stamps.include?(stamp)
  end
end
