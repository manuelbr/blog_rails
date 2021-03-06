# Blog personal de Manuel Blanco

Blog de práctica para aprendizaje de Ruby on Rails

Enlace al curso: https://codigofacilito.com/cursos/rails

## Apuntes básicos sobre Ruby on Rails

### Creación de un proyecto

Para crear un proyecto en Ruby on Rails, basta con ejecutar el comando:

```
rails new (nombre del proyecto)
```

Si el mencionado framework está bien configurado, se creará un árbol de directorios, dentro de un fichero con el nombre del proyecto que hemos especificado. Si entramos dentro de esa carpeta y ejecutamos el comando: "rails server", entrará en funcionamiento el servidor en local que contiene el proyecto. Podemos acceder a su visualización en:

```
http://localhost:3000/
```


### Base de datos

Lo primero que hacemos al tener el proyecto listo es crear la base de datos, que puede hacerse con: "rake db:create", lo cuál prepara la base de datos por defecto que rails tiene especificada (sqlite si no modificamos nada). En caso de querer añadir otras bd, podríamos hacerlo en el mismo comando rake, especificando mysql o postgreSQL.

#### Modelos

Los modelos son las instancias de las tablas de la base de datos. Por convención se les pone nombre en inglés en singular, porque rails crea su tabla asociada en el plural del nombre que le dimos al modelo. Si por ejemplo queremos tener una tabla de personas, crearíamos un modelo llamado: "Person" (que tendría los campos nombre, dni, lugar de origen, etc). La tabla que crearía rails, sería una colección de esas instancias a la que llamaría "Persons (o People)". Para crear un modelo se usa el comando:

```
rails generate model (Nombre del modelo) (campos)
```

En el comando de creación del modelo, después de especificar su nombre, es necesario determinar los campos que lo conforman. A la par, se tiene que especificar la tipología de los mismos (string, integer, float, text, etc). Todos los tipos de datos de las bases de datos en rails, se pueden consultar [aquí](https://stackoverflow.com/questions/17918117/rails-4-list-of-available-datatypes). Un ejemplo de creación de un modelo (siguiendo con el planteado anteriormente)  podría ser:

```
rails generate model Person nombre:string curriculum:text edad:integer"
```

Una vez que se crea el modelo, es necesario migrar la base de datos. Migrar la base de datos consiste en volver a "compilarla" (no es exactamente eso) con los cambios que le hemos realizado. En db/migrate se encuentran los diferentes archivos que tienen el código de los cambios que se hacen en la base de datos que deifinimos. Los cambios se definen agrupados por clases. Por ejemplo: Puede haber una clase para creación de tablas, donde cada método consiste en la creación de una. De igual forma pasa con los UPDATES o las consultas. Para ejecutar la migración en rails se ejecuta el comando: "rake db:migrate".

 * En configuration/database.yml se definen las diferentes bases de datos que usará el proyecto (en función si es en la versión test, producción o desarrollo). Podemos definir el tipo que queramos de base de datos y rails trabajará de forma transparente con todas ellas, de la misma forma.

#### Relaciones 1 a muchos

Las relaciones entre modelos se pueden definir en la consola de rails con comandos como el siguiente:

```
rails generate migration add_user_id_to_articles user:references
```

En este comando, lo que hacemos es generar un archivo de migración que rake puede ejecutar para llevar a cabo una serie de cambios sobre la base de datos. Los cambios en cuestión son la definición de relaciones entre modelos. Por ejemplo, en el caso anterior, se define una relación 1 a muchos: add_(nombre del modelo emisor de la relación)_id_to_(nombre del modelo receptor de la relación). En ese comando se establece que el user_id que se va colocar en la tabla articles es una referencia al de la tabla original "user" (user:references). Como he dicho anteriormente, este comando provoca la creación de un fichero de migración, que ejecutado con rake, realiza los cambios pertinentes sobre la base de datos:

```
rake db:migrate
```

Pese a todo ésto, aún debe terminar de definirse la relación entre los modelos, en sus respectivos archivos .erb de la carpeta "models":


 * Utilizamos la etiqueta "belongs_to :nombre_del_modelo_al_que_pertenece", para establecer la relación de pertenencia por parte de un modelo hacia otro.

 * Se usa la etiqueta "has_many :nombre_del_modelo_del_que_se_tiene_muchos" para establecer que este modelo (cuyo archivo .erb se está modificando en models) está relacionado con muchas instancias del modelo que se especifica.

Estas últimas etiquetas, son las que permiten que en el código de los controladores podamos hacer referencia a estas relaciones entre modelos. Por ejemplo, si hemos definido una relación de 1 usuario que tiene conexión con muchos artículos:

```
// articles.erb

belongs_to :user

// user.erb

has_many :articles

```

Podemos hacer referencias como las siguientes en los controladores:

```
@article.user.email //(Tiene una referencia a su objeto user completo asociado)

@article = current_user.articles.last

```


### Controlador

Los controladores almacenan la lógica de funcionamiento de las webs en rails. Se definen en archivos "html.erb", que son el equivalente a las plantillas "html.twig". En estos ficheros se puede definir el contenido html mezclado con la lógica establecida en ruby. Para crear un controlador basta con el comando:

```
rails generate controller (nombre del controlador) (nombre de la plantilla, del tipo html.erb)
```

Si por ejemplo creamos un controlador para hacer un "hola mundo", debemos usar el comando: "rails generate controller welcome index". Para acceder a su visualización, podemos hacerlo a través de la url: dominio/welcome/index.

Para modificar la definición del controlador, se puede hacer en la carpeta "views" del proyecto. En ella hay una carpeta por cada controlador creado en rails. Dentro del mencionado directorio, debe haber un fichero html.erb donde se describe su contenido. Un ejemplo del mismo puede ser el siguiente:

```
<h2>Bienvenido al blog personal de Manuel Blanco</h2>

<%# <% sólo evalúa lógica de programación en ruby. <%= lo evalúa y muestra el resultado en el html %>

<% num = 0
  [1,2,3,4].each do |numero| %>
    <p>Número <%= numero %></p>
    <% num = numero
  end
%>

<%= "El último número es: #{num}" %>
```

En el trozo de código anterior, se pueden destacar tres elementos principales:

 + Código html.
 + Código .erb.
 + Código ruby dentro de las etiquetas de '.erb': "<%".

Las dos etiquetas principales de las plantillas .erb son: "<% %>" y "<%= %>". Ambas engloban código ruby, pero tienen funcionalidad ligeramente diferente. A continuación se definen cada una por separado.

 * <% %> -> Evalúa la lógica en ruby que contiene.
 * <%= %> -> Evalúa la lógica en ruby que contiene y además muestra el resultado.

Para concluir la diferencia entre las dos etiquetas, se puede decir que "<% %>" interpreta únicamente código en ruby, mientras que "<%= %>", además de interpretarlo puede mezclar el resultado de su evaluación con texto plano, para representar los resultados.

### Vistas

Las vistas agrupan el código que se repite a lo largo de los controladores de la web. Por ejemplo, si en nuestro proyecto de blog tenemos una sección específica para la organización de los artículos, lo normal es que el código que se repita de esta sección, se aglomere en una vista concreta, mientras que el comportamiento específico de las diferentes funcionalidades, se defina en los controladores.

En este momento, ya podemos distinguir entre dos tipos de contenido dentro de la carpeta "views". Por un lado, cada controlador supone un directorio dentro de la mencionada carpeta. Dicha carpeta tiene un archivo .html.erb para definir la representación visual de la funcionalidad, de cada operación definida en el archivo 'controller.rb'. Es decir. hay una vista para cada función específica de un controlador. Por otro lado, existe una única carpeta llamada "layouts" en la que se agrupa el código de la aplicación que es general a ciertos sitios, de cara a utilizarlo desde diferentes sitios. Mientras que la vista de un controlador se puede componer de diferentes ficheros, una vista pura (haciendo caso de la lógica para que fueron inventadas) es un sólo "html.erb".

Una de las partes más características de una vista es el head: la cabecera que contiene los metadatos de la página, que incluye los scripts, hojas de estilo y demás "assets" que se repiten a lo largo de una serie de páginas. Esta sería una vista pura.

### Rutas

Las rutas definen las posibles urls que puede contemplar la aplicación web. Se definen en el archivo "routes.rb", dentro de la carpeta "config" del proyecto. La sintaxis de este fichero se basa en la definición de tres elementos por cada ruta:

  - Verbo: Get, post, delete, put, patch (El verbo http con el que se hace la llamada, en función de lo que se quiera).
  - Controlador: El controlador que recibe la acción. En dicho controlador se define el plan de actuación para esta llamada.
  - Opciones: Los parámetros que se pasan adjuntos a la llamada. Pueden ir incluidos como parte de la url o en forma de sintaxis específica de archivos ".rb". Las opciones pueden ser funcionalidades específicas del controlador o datos que se le pasan a éstas.

Así por ejemplo, una ruta definida podría quedar como: "get '/articles/new' ", en la que especificamos que rails aceptará una petición de tipo get al controlador "articles", sobre su funcionalidad "new". Si se van a definir múltiples rutas para un mismo recurso (como un controlador, por ejemplo), se pueden agrupar bajo el mismo bloque, siguiendo la sintaxis del siguiente ejemplo:

```
resources :articles
  get "/articles"
  post "/articles"
  delete "/articles"
  get "/articles/:id"
  get "/articles/new"
  get "/articles/:id/edit"
  patch "/articles/:id"
  put "/articles/:id"
end
```

Hay que remarcar que definir las rutas de una aplicación, no significa la definición del plan de actuación frente a ellas. Ello se planifica sobre los controladores en los que está previsto recibir esas llamadas. En nuestro caso de ejemplo, en articles.

### Consola de rails y gestión de bd mediante consola

Nosotros podemos ejecutar el código ruby que insertamos en las plantillas de rails, directamente desde la consola que nos proporciona. Esto se suele utilizar mucho cuando tenemos que hacer consultas, inserción o mantenimiento de las bases de datos que gestiona la aplicación en rails. Una forma de acceder a la mencionada consola, es a través del comando: "rails console". En esta terminal, podemos ver, insertar, eliminar o actualizar tuplas de la base de datos, como si de mysql se tratara, pero con la sintaxis de ruby.

Por otra parte, cada instancia de la base de datos (hay que recordar) se considera un modelo, por lo que podemos consultar y modificar su estructura en cuanto a columnas y atributos, en el fichero: models/(nombre del modelo). A su vez, por ser un modelo (que hereda de "Active Records"), esta instancia dispone de una serie de funciones predefinidas para trabajar con ella como si se tratara de un elemento normal de base de datos. De esta forma, podemos encontrar funciones: "delete, update, create, etc", pre-definidas para él. Por ejemplo, si quisiéramos hacer una inserción (insert into) de un elemento en la tabla "articles", la sintaxis de la orden sería la siguiente:

```
Article.create(titulo:"Primer artículo", contenido: "Bienvenido a mi blog", numero_visitas: 0)

```
Si queremos definir una función personalizada para un modelo, podemos hacerlo en su fichero correspondiente: models/(nombre del modelo). En el siguiente [enlace](http://guides.rubyonrails.org/active_record_querying.html), se listan algunas de las funciones predefinidas de los modelos, que hacen las veces de los "select", "update" o "delete" habituales. Por ejemplo, para hacer un describe, podemos usar la función "(nombre del modelo).attribute_names".

#### Funciones de la consola de Ruby on Rails para ActiveRecord

Una de las mejores cosas de Ruby on Rails es el uso de ActiveRecord, que es la capa de rails que abstrae las operaciones con Base de Datos, de forma que con el mismo código podemos cambiar el tipo de base de datos, sin que afecte a nada. Por ejemplo, de un momento a otro podemos pasar de usar SQL a MongoDB, sin ninguna repercusión sobre el código del proyecto.

Dentro de una instancia de ActiveRecord, en la consola de rails (o en el mismo código) podemos usar diferentes funciones para sustituir lo que haríamos con código de lenguaje de base de datos. Algunas de estas funciones son:

 * Por defecto, ActiveRecord usa un entero auto incrementable como clave primaria de las instancias, y por tanto cuando hacemos lo siguiente: Article.find(2), se busca el elemento con id=2, pero no hay que olvidar que ese id es invisible al usuario.

 * Si queremos buscar por otro tipo de campo: Article.find_by(titulo:"Segundo título").

 * Article.where("titulo LIKE ?", "%articu%") -> Para consultas más complejas, por condiciones. Las variables en las consultas se ponen usando el símbolo clave "?". Por cada "?" se pasa (separados por comas) los valores de las variables.

 La diferencia entre find y la clausula where es que con find, se devuelve un único elemento (el primero que coincide con la condición), pero con where obtenemos un array con todos los elementos como resultado.

 Ejemplo complejo: Article.where("id = ? OR title = ?", params[:id], params[:title]), en caso de usar la funcionalidad en el código del controlador artículo.

 * Se puede añadir la función ".not" a la de "where". Ejemplo: Article.where.not("id = ? ","3").


## Notas sueltas

* El orden de funcionalidad dentro de una aplicación rails es: Ruta (llamada) -> Controlador (plan de acción) -> Modelo (Instancia de base de datos) -> Vista (donde se muestran los resultados de la lógica ejecutada en el plan de acción).

* Las gemas en Ruby on Rails son plugins de extensión que se añaden a los proyectos en este tipo de Frameworks. En este [enlace](https://rubygems.org), se pueden buscar todas las gemas (y la sintaxis para saber cómo añadirlas) en Ruby on Rails. Las gemas se añaden en el fichero "Gemfile" y se instalan en el proyecto (habiendo parado el servidor) todas las gemas que haya especificadas en el fichero, descargando las que sean necesarias, con el comando bundle install.

  Tras ésto, se pueden instalar de forma manual las gemas que hayan sido incluidas como nuevas en el fichero Gemfile (después de haber hecho bundle install).

  ```
  rails g (nombre de la gema):install .
  ```

  Si reiniciamos el servidor, éste automáticamente detecta aquellas gemas que son nuevas y las instala, después de haber hecho "bundle install".

  En el caso concreto de la gema devise, se puede usar para la autenticación de usuarios:

  ```
  rails g devise (Nombre del modelo de tipo usuario)
  ```

  El anterior comando crea un modelo de tipo Usuario, con correo electrónico, contraseña, nombre de usuario, etc; Todo orientado a la autenticación con usuarios.

 * En db/schema.rb se puede consultar la estructuras de todas las tablas de la base de datos.
 * Para especificar que un modelo forma parte de otro (esto es el concepto de "anidación"), se coloca su definición dentro de la del modelo padre, en del archivo "routes". Por ejemplo:

  ```
  //El modelo comentario forma parte del modelo artículo.
  resources :articles do
    resources :comentarios, only: [:create, :update, :destroy]
  end
  ```
