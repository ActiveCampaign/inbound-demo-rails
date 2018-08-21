class ArticlesController < ApplicationController
  def index
    @title = "ACME Blog Co."
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @title = @article.title
  end
end
