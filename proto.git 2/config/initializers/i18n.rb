module I18n
  class MissingTranslation
    def html_message
      "#{keys.pop.to_s.titleize}"
    end
  end
end 
