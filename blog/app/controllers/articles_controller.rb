class ArticlesController < ApplicationController
  # Funcionalidad index del controlador articles.
  def index
    @article = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
