module RN::Commands::Notes
    class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: false, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'
        option :help, type: :boolean, desc: 'Hiperlink to reference of Markdown syntax'

        def call(title="", **options)
          options[:help] ? (return puts 'Acceda a https://kramdown.gettalong.org/quickref.html para información sobre la sintaxis de Markdown') : ()
          options[:book] ? (
            book = RN::Models::Book.new ARGV[-1]
            title = ARGV[-3]) :
            (book = RN::Models::Book.new ""
            title = ARGV[-1])

          note = RN::Models::Note.new title,book
          note.show_and_edit
        rescue RN::Exceptions::ExcepcionesModelo => e
          warn e.message
      end
    end
end