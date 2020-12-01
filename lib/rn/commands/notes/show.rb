module RN::Commands::Notes

    class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        include Paths
        include Notes

        def call(title:, **options)
          options[:book] ? book = self.path(ARGV[-1]) : book = self.root
          self.show_and_edit(title, book)
        end


    end
end
