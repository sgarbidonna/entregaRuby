require 'fileutils'
require_relative '../../helpers/paths'

module RN
  module Commands
      module Books
        class Create < Dry::CLI::Command
          desc 'Create a book'
          argument :name, required: true, desc: 'Name of the book'

          include Paths

          def call(name:, **)
            if self.validate(name) then
              FileUtils.mkdir_p self.path(name)
              warn "Cuaderno '#{name.upcase}' creado!!"
            end
          end

        end

        class Delete < Dry::CLI::Command
          desc 'Delete a book'

          argument :name, required: false, desc: 'Name of the book'
          option :global, type: :boolean, default: false, desc: 'Operate on the global book'

          include Paths

          def call(name: nil, **options)
            if options[:global] then
              if Dir.glob("#{self.root}/*").empty? then warn "No hay notas que eliminar"
              else
                FileUtils.rm_rf(Dir.glob("#{self.root}/*"))
                warn "Acaba de eliminar todas las notas contenidas en el cuaderno global #{self.root}"
              end
            elsif !name.nil?
              FileUtils.remove_entry_secure self.path(name)
              warn "Acaba de eliminar el cuaderno '#{self.path(name).split("/")[-1].upcase}' y todas las notas allí contenidas"
            else warn "No se realizó ninguna tarea ya que no ingresó ningún argumento. \n Acompañe el comando con '--global' para borrar las notas contenidas en el caderno global. \n O bien, con el nombre de un cuaderno existente que quiera eliminar junto con su contenido"
            end
          end
        end

        class List < Dry::CLI::Command
          desc 'List books'
          include Paths

          def call(*)
            puts Dir.glob("#{self.root}/*").map {|path| path.split("/")[-1]}
            # puts Dir.entries(self.root).select {|f| File.directory?(File.join(self.root,f))}
            # puts Dir.glob("#{self.root}/*")
          end
        end

        class Rename < Dry::CLI::Command
          desc 'Rename a book'

          argument :old_name, required: true, desc: 'Current name of the book'
          argument :new_name, required: true, desc: 'New name of the book'

          include Paths

          def call(old_name:, new_name:, **)
            if self.exists(old_name) then
              if self.validate(new_name) then
                FileUtils.mv self.path(old_name), self.path(new_name)
                warn "El antiguo cuaderno de nombre '#{old_name}' pasó a llamarse '#{new_name}'."
              else warn "No puede incluir símbolos en el nombre del cuaderno" end
            else warn "No existe ningun cuaderno con el nombre '#{old_name}'." end
          end
        end
      end
  end
end
