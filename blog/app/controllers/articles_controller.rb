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
  #Aquí se define la lógica que hay que seguir para introducir una instancia vacía de artículo en base de datos.
  def new
    #Como no se guarda después de haberlo creado, no entra en la base de datos. Es como un constructor por defecto.
    @article = Article.new
  end

  #POST articles/create
  #Aquí se define la lógica que hay que seguir para crear la nueva instancia que se ha definido en new
  def create
    @article = Article.new(titulo: params[:article][:titulo], contenido: params[:article][:titulo])

    # Si el guardado del modelo es correcto (ha pasado también las validaciones) redireccionamos a
    # verlo.
    if @article.save
      redirect_to @article
    else # En caso de que haya habido algún problema o no haya pasado las validaciones (fichero article en models)
      render :new
    end
  end

  #DELETE articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path # redirige a articles/index.
  end
end
