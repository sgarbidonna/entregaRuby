module RN::Commands::Books
    class Create < Dry::CLI::Command
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'


        def call(name:, **)
            book = RN::Models::Book.new name

            book.create
            puts "Cuaderno '#{name.upcase}' creado!!"

        rescue RN::Exceptions::ExcepcionesModelo => e
            warn e.message
        end
    end
end