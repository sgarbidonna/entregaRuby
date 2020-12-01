module RN::Commands::Books
    class List < Dry::CLI::Command
        desc 'List books'

        def call(*)
            puts RN::Models::Book.list
        end
    end
end