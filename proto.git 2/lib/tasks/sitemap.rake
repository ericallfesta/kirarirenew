namespace :sitemap do
  task generate: :environment do
    sitemap_path = Rails.root.join("public", "sitemap.xml").to_s
    _ = []
    _ << SitemapUrl.new( loc: '/', changefreq: 'always', priority: '1.0' )
    Product.published.each do |product|
      _ << SitemapUrl.new( model: product, changefreq: 'daily', priority: '1.0' )
    end
    Brand.all.each do |brand|
      _ << SitemapUrl.new( model: brand, changefreq: 'weekly', priority: '0.6' )
    end
    Report.published.each do |report|
      _ << SitemapUrl.new( model: report, changefreq: 'monthly', priority: '0.8' )
    end
    Question.published.each do |question|
      _ << SitemapUrl.new( model: question, changefreq: 'monthly', priority: '0.8' )
    end
    content = <<-SITEMAP
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  #{_.map{|v|v.to_xml}.join("\n")}
</urlset>
    SITEMAP
    file = File.new(sitemap_path, 'w')
    file.write(content)
    file.close
  end
end
