module RN::Commands::Books
    class Create < Dry::CLI::Command
        desc 'Create a book'
        argument :name, required: true, desc: 'Name of the book'

        include Paths

        def call(name:, **)
            if self.validate(name)
                FileUtils.mkdir_p self.path(name)
                warn "Cuaderno '#{name.upcase}' creado!!"
            end
        end

    end
end