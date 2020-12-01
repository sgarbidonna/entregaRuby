module RN::Commands::Notes
    class Create < Dry::CLI::Command
        desc 'Create a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        def call(title:, **options)

            options[:book] ? (book = RN::Models::Book.new ARGV[-1]) : (book = RN::Models::Book.new "")
            note = RN::Models::Note.new(title,book)
            note.create
            puts "La nota '#{title.upcase}' se creó exitosamente"
        end
    end
end