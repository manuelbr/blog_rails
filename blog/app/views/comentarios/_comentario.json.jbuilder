json.extract! comentario, :id, :user_id, :article_id, :body, :created_at, :updated_at
json.url comentario_url(comentario, format: :json)
