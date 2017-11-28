class CreateArticles < ActiveRecord::Migration[5.1]
  # Aquí se realizan los cambios en base de datos. En vez de hacerlos directamente sobre ella.
  # Ello es una forma transparente de gestionar diferentes tipos de bases de datos con el mismo código.
  def change
    create_table :articles do |t|
      t.string :titulo
      t.text :contenido
      t.integer :numero_visitas

      t.timestamps
    end
  end
end
