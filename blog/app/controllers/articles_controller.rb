class ArticlesController < ApplicationController
  # Funcionalidad index del controlador articles.

  # Esta etiqueta hace referencia a los métodos que se ejecutan primero de todo,
  # al ejecutar cualquier funcionalidad de este ActiveRecord. La opción only
  # permite determinar las funciones a las que queremos limitar el hecho de
  # llamar a esta función por defecto. El efecto contrario lo hace "except".

  #En este caso, la función authenticate_user está definida en los fuentes de devise,
  # por ello no está aquí.
  before_action :authenticate_user!, only: [:create,:new]
  before_action :find_article, except:[:index,:new,:create]

  # GET articles
  # Muestra todos los artículos
  def index
    @article = Article.all
  end

  # GET articles/:id
  #Muestra un artículo en concreto
  def show
    @comentario = Comentario.new
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

    # current_user tiene articles como atributo porque he establecido en user.rb que un usuario has_many articles.
    @article = current_user.articles.new(titulo: params[:article][:titulo], contenido: params[:article][:contenido])

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

  end

  #PUT articles/:id
  def update
    if @article.update({titulo: params[:article][:titulo], contenido: params[:article][:contenido]})
      # ó también se puede poner como @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  #DELETE articles/:id
  def destroy
    @article.destroy
    redirect_to articles_path # redirige a articles/index.
  end

  def find_article
    #Encontramos el artículo.
    @article = Article.find(params[:id])
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
