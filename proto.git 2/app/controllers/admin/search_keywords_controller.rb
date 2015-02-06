class Admin::SearchKeywordsController < AdminController
  def index
    @today = SearchKeyword.instance.today
    @yesterday = SearchKeyword.instance.yesterday
  end
end
