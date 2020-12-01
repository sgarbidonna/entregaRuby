module RN::Commands::Books
    class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        include Paths

        def call(name: nil, **options)
            if options[:global]
                (return warn "No hay notas que eliminar") if Dir.glob("#{self.root}/*").empty?
                FileUtils.rm_rf(Dir.glob("#{self.root}/*"))
                warn "Acaba de eliminar todas las notas contenidas en el cuaderno global #{self.root}"
            elsif !name.nil?
                FileUtils.remove_entry_secure self.path(name)
                warn "Acaba de eliminar el cuaderno '#{self.path(name).split("/")[-1].upcase}' y todas las notas allí contenidas"
            else warn "No se realizó ninguna tarea ya que no ingresó ningún argumento. \n Acompañe el comando con '--global' para borrar las notas contenidas en el caderno global. \n O bien, con el nombre de un cuaderno existente que quiera eliminar junto con su contenido"
            end
        end
    end
end