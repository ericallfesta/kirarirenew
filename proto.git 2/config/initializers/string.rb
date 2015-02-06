class String
  include ActionView::Helpers::TagHelper

  def excerpt(strip_tag: false, length: 62)
    text = self.gsub(/\r\n|\n/, ' ').split(//u)[0, length].join
    return text unless text.length < self.length
    text + (strip_tag ? content_tag(:span, '...', class: 'more') : '...')
  end
end
