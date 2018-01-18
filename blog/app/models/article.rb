class Article < ApplicationRecord
  # Un modelo es el objeto que puede ser constituido como elemento de la base de datos. Se transforma a la unidad de medida de la base de datos.
  # El nombre de la tabla que tiene muchos modelos del mismo tipo se llama igual que el modelo, pero en plural. En este caso: artículos.
  # Los campos de la tabla que tiene muchos modelos son los del modelo.

  # Para crear un modelo de ejemplo: "rails generate model Article titulo:string contenido:text numero_visitas:integer" . Cada
  # uno de los campos tiene un tipo: string, text, integer, float, etc. Se traducen a varchar, string y demás tipos de valor típicos
  # de SQL, en caso de que ese sea el tipo de base de datos utilizada.


  # Especificamos que queremos que esos atributos del modelo no sean null, obligamos a que tengan un valor como en SQL.
  validates :titulo, presence: true, uniqueness: true # El título es clave primaria
  validates :contenido, presence: true, length: {minimum: 20}
end
