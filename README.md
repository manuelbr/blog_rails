# Blog personal de Manuel Blanco

Blog de práctica para aprendizaje de Ruby on Rails

Enlace al curso: https://codigofacilito.com/cursos/rails

## Apuntes

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

En este momento, ya podemos distinguir entre dos tipos de contenido dentro de la carpeta "views". Por un lado, cada controlador supone un directorio dentro de la mencionada carpeta. Por otro, existe una única carpeta llamada "layouts" para almacenarlas. Mientras que un controlador se puede componer de diferentes ficheros, una vista (haciendo caso de la lógica para que fueron inventadas) es un sólo "html.erb".

Una de las partes más características de una vista es el head: la cabecera que contiene los metadatos de la página, que incluye los scripts, hojas de estilo y demás "assets" que se repiten a lo largo de una serie de páginas.
