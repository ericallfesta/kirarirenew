module HtmlHelper
  def indicator(number, unit)
    content_tag :li, class: :indicator do
      icon(unit) + link_to("##{unit}") do
        num = content_tag(:span, number, class: :num)
        unit = content_tag(:span, t("views.#{unit}"), class: :unit)
        raw "#{num}#{unit}"
      end
    end
  end
end
