class Search::BasicController < ApplicationController
  after_action :get_try_search_stamp, only: :result
  before_action :meta_noindex

  def index
  end

  def result
    respond_to do |format|
      format.json do
        @queries = SearchQuery.new search_params
        @products = Product.published.search(search_params).page(params[:page]).per(10)
      end
      format.html do
        return redirect_to search_basic_path if search_params.blank?
        SearchKeyword.instance.push(face: search_params[:q])
        @search_params = search_params
        @keywords = @search_params.map{|k, v| v.try(:name) || v }.join(' ')
        @results = [
          SearchResult.new(proxy: Product.published.search(@search_params), as: :products)
        ]
        if @search_params.has_key?(:q) && @search_params[:q] != ''
          @results << SearchResult.new(
            proxy: Diary.search(@search_params),
            as: :writings, has_list: true, heading: 'search_diaries', action: :diaries)
          @results << SearchResult.new(
            proxy: Report.published.search(@search_params),
            as: :writings, has_list: true, heading: 'search_reports', action: :reports)
          @results << SearchResult.new(
            proxy: Question.published.search(@search_params),
            as: :writings, has_list: true, heading: 'search_questions', action: :questions)
        end
      end
    end
  end

  def products
    respond_to do |format|
      format.json do
        @queries = SearchQuery.new search_params
        @products = Product.published.search(search_params).page(params[:page]).per(10)
      end
      format.html do
        return redirect_to search_basic_path if search_params.blank?
        SearchKeyword.instance.push(face: search_params[:q])
        @keywords = search_params.map{|k, v| v.try(:name) || v }.join(' ')
        @products = Product.published.search(search_params).page(params[:page]).per(25)
      end
    end
  end

  def reports
    return redirect_to search_basic_path if search_params.blank?
    SearchKeyword.instance.push(face: search_params[:q])
    @keywords = search_params.map{|k, v| v.try(:name) || v }.join(' ')
    @reports = Report.published.search(search_params).page(params[:page]).per(25)
  end

  def diaries
    return redirect_to search_basic_path if search_params.blank?
    SearchKeyword.instance.push(face: search_params[:q])
    @keywords = search_params.map{|k, v| v.try(:name) || v }.join(' ')
    @diaries = Diary.search(search_params).page(params[:page]).per(25)
  end

  def questions
    return redirect_to search_basic_path if search_params.blank?
    SearchKeyword.instance.push(face: search_params[:q])
    @keywords = search_params.map{|k, v| v.try(:name) || v }.join(' ')
    @questions = Question.published.search(search_params).page(params[:page]).per(25)
  end

  protected
    def search_params
      permit_params.merge({
        tag: Tag.find_by(id: permit_params[:tag]),
        category: TagGroup.category.tags.find_by(id: permit_params[:category]),
        brand: permit_params[:brand]
      }).delete_if {|k, v| v.blank? }
    end

    def permit_params
      params.permit(:tag, :q, :kana, :category, :brand, :page, :format)
    end

    def get_try_search_stamp
      return unless logged_in?
      stamp = Stamp.find_by slug: 'try_search'
      current_user.stamps << stamp if stamp.present? && ! current_user.stamps.include?(stamp)
    end
end
