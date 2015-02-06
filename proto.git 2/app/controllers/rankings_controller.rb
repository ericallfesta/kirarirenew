class RankingsController < ApplicationController
  def index
    @categories = TagGroup.category.tags
  end

  def show
    @target = Tag.find(params[:id].gsub(/[^0-9]+/, '').to_i) if params[:id] =~ /tag/
    @products = Product.score_ranking.in(@target, association_name: :recursive_products).page params[:page] unless @target.nil?
    @products = Product.score_ranking.ranged(:yesterday).page params[:page] if @products.nil?
  end

  def pickup
    @headline = Tag.random_categories.limit(1).first
    @pickups = Tag.random_categories.limit(2)
  end
end
