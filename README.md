# Decisiones de diseño

Se trabajó en el refactorizado del modelo de datos, como había sido señalado en el coloquio.
Ahora podremos encontrar en el directorio `lib/rn/models` del proyecto, nuestros nuevos modelos.
Tanto en el caso de RN::Models::Book como en el caso de RN::Models::Note utilicé la palabra reservada
alias_method para el constructor (new), ya que muchas veces no se buscaba instanciar un nuevo objeto,
porque éste existía o 'persistía' en nuestro SO. Si bien el resultado de :open como el de :new
es el mismo, se tomó esta decisión para lograr mejor lectura del código.

Se podrá ver que para cada modelo existen varios métodos del tipo self, esto se decidió porque
había ocasiones en las que se quería trabajar sobre la entidad y no sobre una nota en particular.

Lógicamente los anteriores 'helpers' fueron eliminados. También se podrá notar que en el archivo
`lib/rn/commands/books.rb` (por ejemplo), se modularizó por cada command aceptable por el sistema
en cuestión. Por lo que en dicho archivo solo encontraremos el 'autoload' de sus funcionalidades.

Se agregó la constante global RN::Exceptions::ExcepcionesModelo, que hereda de la clase Exception.
Se eligió a ésta para la herencia, debido a la generalización de los siguientes 'hijos' de la
nueva constante declarada. Es decir que ArgumentError iba a funcionar para el caso de
RN::Exceptions::FormatoInvalido mas no para RN::Exceptions::ExisteIdentico.


## Nuevas funcionalidades

Se podrá encontrar una nueva funcionalidad correspondiente a la entrega actual: exportar a '.html'
los archivos '.rn' . Para ello se utilizó la gema kramdown y se hardcodeó el código con el fin
de sólo exportar en '.html'.

En cuanto a la funcionalidad 'delete' del command pertinente a books, se agregó la opción de
eliminar sólo las notas del primer nivel de nuestro sistema de cuadernos. Esto quiere decir
que actualmente podremos: borrar un cuaderno en particular, borrar todos los cuadernos, y borrar
las notas del primer nivel.

Debido a que se agregaron nuevas funcionalidad es que se reversionó el Minor. Debido a que se modificó
la estructura total del sistema es que se reversionó el Mayor. Por tanto, de versión tenemos: '2.2.0'

### Instalación de dependencias

Para el manejo de archivos se utiliza la gema FileUtils. Para ello:

```bash
$ gem install fileutils
```

Para editar y ver una nota este proyecto utiliza TTY-Editor. Para ello:

```bash
$ gem install tty-editor
```

Para la exportaciones de los archivos se utiliza Kramdown. Para ello:

```bash
$ gem install kramdown
```

### Estructura de la plantilla

Acompañando a lo comentado anteriormente, se deja constancia explícita de los directorios
de los nuevos cambios. A fin de facilitar la visión general del proyecto:

* `lib`: ningun cambio
  * `lib/rn.rb`: nuevos autoloads: Models y Exceptions.
  * `lib/rn/`: nuevos archivos: `lib/rn/exceptions.rb` y `lib/rn/models.rb`
  * `lib/rn/models`: nuevo directorio, allí encontramos las clases RN::Models::Book y RN::Models::Note
  * `lib/rn/commands/books` y `lib/rn/commands/notes`: donde encontrar cada 'class Ejemplo < Dry::CLI::Command'
  encargada de preparar los datos para que cada clase termine de ocuparse.
* `bin/`: ningun cambio