require 'fileutils'
require_relative '../paths'

module RN
  module Commands
      module Books
        class Create < Dry::CLI::Command
          desc 'Create a book'
          argument :name, required: true, desc: 'Name of the book'

          include Paths

          # example [
          #   '"My book" # Creates a new book named "My book"',
          #   'Memoires  # Creates a new book named "Memoires"'
          # ]

          def call(name:, **)
            FileUtils.mkdir_p self.path(name)
            warn "Cuaderno creado con éxito'#{name}'.\nPodés accederlo entrando a #{self.root}."
          end

        end

        class Delete < Dry::CLI::Command
          desc 'Delete a book'

          argument :name, required: false, desc: 'Name of the book'
          option :global, type: :boolean, default: false, desc: 'Operate on the global book'

          include Paths
          # example [
          #   '--global  # Deletes all notes from the global book',
          #   '"My book" # Deletes a book named "My book" and all of its notes',
          #   'Memoires  # Deletes a book named "Memoires" and all of its notes'
          # ]

          def call(name: nil, **options)
            if options[:global] then
              # FileUtils.rm_rf(Dir.entries(self.root))
              warn "Acaba de eliminar todas las notas contenidas en el cuaderno global #{self.root}"
            elsif !name.nil? then
              FileUtils.remove_entry_secure self.path(name)
              warn "Acaba de eliminar el cuaderno #{self.path(name)} y todas las notas allí contenidas"
            end
            warn "No se realizó ninguna tarea ya que no ingresó ningún argumento. \n Acompañe el comando con '--global' para borrar las notas contenidas en el caderno global. \n O bien, con el nombre de un cuaderno existente que quiera eliminar junto con su contenido"
          end
        end

        class List < Dry::CLI::Command
          desc 'List books'

          example [
            '          # Lists every available book'
          ]

          def call(*)

            warn "TODO: Implementar listado de los cuadernos de notas.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          end
        end

        class Rename < Dry::CLI::Command
          desc 'Rename a book'

          argument :old_name, required: true, desc: 'Current name of the book'
          argument :new_name, required: true, desc: 'New name of the book'

          example [
            '"My book" "Our book"         # Renames the book "My book" to "Our book"',
            'Memoires Memories            # Renames the book "Memoires" to "Memories"',
            '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
          ]

          def call(old_name:, new_name:, **)
            warn "TODO: Implementar renombrado del cuaderno de notas con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          end
        end
      end
  end
end
