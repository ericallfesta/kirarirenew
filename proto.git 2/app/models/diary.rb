class Diary < Writing
  has_many :notifications, as: :noticeable

  validates_length_of :title, in: 4..64

  after_save :get_write_diary_stamp

  default_scope -> { order updated_at: :desc }

  def label
    self.title
  end

  def is_mine? current_user
    ! current_user.nil? && current_user.id == writer.id
  end

  def next
    Diary.where('writer_id = ? AND created_at > ?', writer_id, created_at).order( created_at: :asc).first
  end

  alias :next_diary :next

  def prev
    Diary.where('writer_id = ? AND created_at < ?', writer_id, created_at).order( created_at: :desc).first
  end

  alias :prev_diary :prev

  def get_write_comment_for_stamp comment
    stamp = Stamp.find_by slug: 'write_comment_for_diary'
    comment.user.stamps << stamp if stamp.present? && ! comment.user.stamps.include?(stamp)
  end

  def to_meta
    MetaControl.create self, description: body.excerpt
  end

  private

  def get_write_diary_stamp
    stamp = Stamp.find_by slug: 'write_diary'
    self.writer.stamps << stamp if stamp.present? && ! self.writer.stamps.include?(stamp)
  end
end
