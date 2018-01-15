class ArticlesController < ApplicationController
  # Funcionalidad index del controlador articles.
  # GET articles
  # Muestra todos los artículos
  def index
    @article = Article.all
  end

  # GET articles/:id
  #Muestra un artículo en concreto
  def show
    @article = Article.find(params[:id])
  end

  #GET articles/new
  #Aquí se define la lógica que hay que seguir para introducir una instancia de artículo en base de datos.
  def new
    @article = Article.new
  end
end
