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
    #Si le pasaramos al new, el objeto article entero que se crea al guardarlo desde la vista, podríamos
    #enviar un objeto con atributos corruptos, que no controlemos.
    #Al especificar en el new el valor de qué atributos queremos tener, evitamos ésto,
    @article = Article.new(titulo: params[:article][:titulo], contenido: params[:article][:contenido])
    #Otra opción es hacer lo siguiente, para determinar las condiciones de funcionamiento que especificamos en article_params:
    #@article = Article.new(article_params)


    # Si el guardado del modelo es correcto (ha pasado también las validaciones) redireccionamos a
    # verlo.
    if @article.save
      redirect_to @article
    else # En caso de que haya habido algún problema o no haya pasado las validaciones (fichero article en models)
      render :new
    end
  end

  #GET articles/:id
  def edit
    #Encontramos el artículo a editar.
    @article = Article.find(params[:id])
  end

  #PUT articles/:id
  def update
    #Encontramos el artículo a actualizar.
    @article = Article.find(params[:id])

    if @article.update({titulo: params[:article][:titulo], contenido: params[:article][:contenido]})
      # ó también se puede poner como @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  #DELETE articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path # redirige a articles/index.
  end

  #Todo lo que definamos a partir de la etiqueta "private" serán métodos o atributos privados.
  private

  #Se trata de un atributo reservado: nombre del ActiveRecord + "_params"
  def article_params
    #Establecemos que para funcionar, se requiere un objeto ActiveRecord de tipo article y que sólo se le permite a ese
    #artículo tener el campo título y contenido rellenos. Este atributo article_params, se llama desde las funciones donde se
    #requiera su presencia para establecer las condiciones de funcionamiento de la misma.
    params.require(:article).permit(:titulo, :contenido)
  end
end
