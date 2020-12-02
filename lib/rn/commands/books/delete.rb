module RN::Commands::Books
    class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'
        option :global_notes, type: :boolean, default: false, desc: 'Operate only on the notes of the global book'

        def call(name: nil, **options)
            
            book_names = []
            book_names << name if name
            book_names << "root" if options[:global]
            book_names << "" if options[:global_notes]

            

            messages = book_names.map do |name|
                book = RN::Models::Book.open name
                book.title == "" ? RN::Models::Book.delete_notes : book.remove

            rescue RN::Exceptions::ExcepcionesModelo => e
                puts e.message
            end.join "\n"

            puts messages
            book_names.empty? ? (puts "No se realizó ninguna tarea ya que no ingresó ningún argumento. \n Acompañe el comando con '--global' para borrar las notas contenidas en el caderno global. \n O bien, con el nombre de un cuaderno existente que quiera eliminar junto con su contenido") : ()
        end



            # if options[:global]

            #     (return warn "No hay notas que eliminar") if Dir.glob("#{self.root}/*").empty?
            #     FileUtils.rm_rf(Dir.glob("#{self.root}/*"))
            #     warn "Acaba de eliminar todas las notas contenidas en el cuaderno global #{self.root}"
            # elsif !name.nil?

            #     FileUtils.remove_entry_secure self.path(name)
            #     warn "Acaba de eliminar el cuaderno '#{self.path(name).split("/")[-1].upcase}' y todas las notas allí contenidas"
            # end
            # rescue RN::Exceptions::ExcepcionesModelo => e
            #     puts e.messages
            # end.join '\n'
       
            # puts messages



            # if options[:global]

            #     (return warn "No hay notas que eliminar") if Dir.glob("#{self.root}/*").empty?
            #     FileUtils.rm_rf(Dir.glob("#{self.root}/*"))
            #     warn "Acaba de eliminar todas las notas contenidas en el cuaderno global #{self.root}"
            # elsif !name.nil?

            #     FileUtils.remove_entry_secure self.path(name)
            #     warn "Acaba de eliminar el cuaderno '#{self.path(name).split("/")[-1].upcase}' y todas las notas allí contenidas"
            # end


    end
end