class CategoriesController < ApplicationController
  def index
    @categories = TagGroup.category.tags.where(parent_id: params[:parent].presence)
    respond_to do |format|
      format.json { render }
    end
  end
end
