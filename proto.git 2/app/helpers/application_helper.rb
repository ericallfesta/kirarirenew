module ApplicationHelper
  def is_home?
    controller_name == 'apps' && action_name == 'home'
  end

  def my_page?
    false
  end

  def search?
    controller_path =~ /\Asearch/
  end

  def meta params
    raw(params.map do |name, content|
      content_tag :meta, nil, name: name, content: ( name == :title ? build_title(content) : content )
    end.join("\n"))
  end

  def auto_link str
    str.gsub!(/https?:\/\/[\w\-\.]+[\w\-](:[0-9]+)?(\/([\w\-\/\.]+)?)?(\?([\w\-\&\_\%\$\@\!\=]+))?/, '<a href="\0" target="_blank">\0</a>')
    sanitize(str, tags: ['a', 'br'], attributes: %w(href target))
  end

  def br str
    sanitize str.to_s.gsub(/\n|\r\n/, '<br>'), tags: ['br'], attributes: []
  end

  def allow_markup str
    content_tag :div,
      sanitize(parse_img_src(str), tags: %w(h1 h2 h3 h4 h5 h6 p div span strong small header section article a br ol ul li br img), attributes: %w(class href target style src width height alt)),
      class: 'allowed_markup_block'
  end

  def parse_img_src html
    html.gsub(/\<img.*?\ src\=\"(.+?)\".*?\>/) { |img| $&.to_s.gsub($1, image_path($1)) }
  end

  def controller_router
    "Kirari.Routers.#{controller_path.gsub('/', ' ').titleize.gsub(' ', '')}Router"
  end

  def push_state_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    html_options.symbolize_keys!
    html_options[:data] ||= {}
    html_options[:data][:pushstate] = true
    link_to(name, options, html_options, &block)
  end

  def heading(name, options={})
    page_heading t("views.heading.#{name}") unless options[:sub]
    image_tag "heading_#{name}.png", alt: t("views.heading.#{name}"), height: 42
  end

  def page_title(separator = ' | ')
    build_title(content_for(:title), separator)
  end

  def build_title(title, separator = ' | ')
    [title, t('views.site_copy')].compact.join(separator)
  end

  def page_heading(title)
    content_for(:title) { title }
    title
  end

  def c(conditions, str)
    return conditions ? str : nil
  end

  def star(val)
    if val.nil?
      return sanitize( '<span class="no-star">' + t('views.no_star') + '</span>', tags: ['span'])
    end

    return val.face if val.is_a? Silverdot::Alternative
    val = val.to_f.round(2)
    star = val.to_i.times.inject('') { |r, v| r += icon('star-full') }
    star += case val - val.to_i
      when 0.01...0.25 then icon('star-empty')
      when 0.25...0.75 then icon('star-half')
      when 0.75..0.99 then icon('star-full')
      else ''
    end
    star += (5 - val.ceil).times.inject('') { |r, v| r += icon('star-empty') }
    sanitize(star, tags: ['span'])
  end

  def icon(name)
    content_tag :span, nil, class: "icon icon-#{name}"
  end

  def kana_list
    {
      'a' => %w(あ い う え お),
      'k' => %w(か き く け こ),
      's' => %w(さ し す せ そ),
      't' => %w(た ち つ て と),
      'n' => %w(な に ぬ ね の),
      'h' => %w(は ひ ふ へ ほ),
      'm' => %w(ま み む め も),
      'y' => %w(や ゆ よ),
      'r' => %w(ら り る れ ろ),
      'w' => %w(わ を ん)
    }
  end

  def or_separator
    content_tag :p, 'or', class: 'or-separator'
  end
end
