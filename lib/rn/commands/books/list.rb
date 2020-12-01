module RN::Commands::Books
    class List < Dry::CLI::Command
        desc 'List books'
        include Paths

        def call(*)
            puts Dir.glob("#{self.root}/*").map {|path| path.split("/")[-1]}
        end
    end
end