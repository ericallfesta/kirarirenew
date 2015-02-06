namespace :brands do
  desc "Convert to kana"
  task convert_kana: :environment do
    Brand.all.each do |brand|
      if brand.kana.present?
        brand.kana = brand.kana.tr('ぁ-ん','ァ-ン')
      else
        brand.kana = brand.name.tr('ぁ-ん','ァ-ン')
      end
      brand.save
    end
  end
end
