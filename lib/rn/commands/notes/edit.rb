module RN::Commands::Notes
    class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'



        def call(title:, **options)

          options[:book] ? (book = RN::Models::Book.new ARGV[-1]) : (book = RN::Models::Book.new "")
          note = RN::Models::Note.new(title,book)
          note.show_and_edit
        end
    end
end