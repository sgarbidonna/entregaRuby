module RN::Commands::Books
    class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        def call(old_name:, new_name:, **)
            oldB = RN::Models::Book.open old_name
            oldB.rename new_name
            puts "El antiguo cuaderno de nombre '#{old_name.upcase}' pasó a llamarse '#{new_name.upcase}'."

        rescue RN::Exceptions::ExcepcionesModelo => e
            warn e.message
        end
    end
end