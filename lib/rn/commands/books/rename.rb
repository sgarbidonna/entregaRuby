module RN::Commands::Books
    class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        include Paths

        def call(old_name:, new_name:, **)
            !self.exists(self.path(old_name)) ? (return warn "No existe ningun cuaderno con el nombre '#{old_name.upcase}'.") : ""
            if self.validate(new_name)
                FileUtils.mv self.path(old_name), self.path(new_name)
                warn "El antiguo cuaderno de nombre '#{old_name.upcase}' pasó a llamarse '#{new_name.upcase}'."
            end
        end
    end
end