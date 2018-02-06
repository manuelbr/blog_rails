class ComentariosController < ApplicationController
  before_action :set_comentario, only: [:show, :edit, :update, :destroy]
  before_action :set_article
  before_action :authenticate_user!

  # GET /comentarios
  # GET /comentarios.json
  def index
    @comentarios = Comentario.all
  end

  # GET /comentarios/1
  # GET /comentarios/1.json
  def show
  end

  # GET /comentarios/new
  def new
    @comentario = Comentario.new
  end

  # GET /comentarios/1/edit
  def edit
  end

  # POST /comentarios
  # POST /comentarios.json
  def create
    @comentario = current_user.comentarios.new(comentario_params)
    @comentario.article = @article

    respond_to do |format|
      if @comentario.save
        format.html { redirect_to @comentario.article, notice: 'Comentario was successfully created.' }
        format.json { render :show, status: :created, location: @comentario.article }
      else
        format.html { render :new }
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comentarios/1
  # PATCH/PUT /comentarios/1.json
  def update
    respond_to do |format|
      if @comentario.update(comentario_params)
        format.html { redirect_to @comentario.article, notice: 'Comentario was successfully updated.' }
        format.json { render :show, status: :ok, location: @comentario.article }
      else
        format.html { render :edit }
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.json
  def destroy
    @comentario.destroy
    respond_to do |format|
      format.html { redirect_to comentarios_url, notice: 'Comentario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comentario
      @comentario = Comentario.find(params[:id])
    end

    def set_article
      #Si especifico que un recurso depende de otro (haciéndolo anidado en el archivo routes),
      #desde el controlador puedo acceder a los parámetros del recurso padre haciendo: params[nombre_del_recurso_padre:atributo]
      @article = Article.find(params[:article_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comentario_params
      params.require(:comentario).permit(:user_id, :article_id, :body)
    end
end
