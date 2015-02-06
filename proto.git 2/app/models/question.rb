class Question < Writing
  validates_presence_of :product, :title
  validates_length_of :title, in: 2..64

  after_create :get_write_question_stamp

  scope :published, -> { includes(:product).where(:'products.state' => 'published') }

  def has_thumbnail?
    true
  end

  def thumbnail
    product.image
  end

  def caption
    product.name
  end

  def get_write_comment_for_stamp comment
    stamp = Stamp.find_by slug: 'write_comment_for_question'
    comment.user.stamps << stamp if stamp.present? && ! comment.user.stamps.include?(stamp)
  end

  def to_meta
    MetaControl.create self, description: product.description
  end

  private

  def get_write_question_stamp
    stamp = Stamp.find_by slug: 'write_question'
    self.writer.stamps << stamp if stamp.present? && ! self.writer.stamps.include?(stamp)
  end
end
