module RN::Commands::Books
    class List < Dry::CLI::Command
        desc 'List books'

        def call(*)
            puts RN::Models::Book.root+"/*".map {|path| path.split("/")[-1]}

            # puts Dir.glob("#{self.root}/*").map {|path| path.split("/")[-1]}
        end
    end
end