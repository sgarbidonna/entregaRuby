module RN::Commands::Notes
    class Delete < Dry::CLI::Command
        desc 'Delete a note'

        option :title, required: false, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, desc: 'Global'

        def call(**options)
          options[:book] ? (book = RN::Models::Book.new ARGV[-1]) : (book = RN::Models::Book.new "")
          options[:global] ? (title= "" ) : ()

          note = RN::Models::Note.open(title, book)
          note.delete options[:global]

          puts "Nota/s eliminada/s"
        rescue RN::Exceptions::ExcepcionesModelo => e
          puts e.message
        end
    end
end