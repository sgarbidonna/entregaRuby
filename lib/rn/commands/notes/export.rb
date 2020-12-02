module RN::Commands::Notes
    class Export < Dry::CLI::Command
      desc 'List notes'

      argument :title, require: :false, desc: 'Title of the note'
      option :book, type: :string, desc: 'Book'
      option :help, type: :boolean , desc: 'Hiperlink to reference of Markdown syntax'

      def call(title="", **options)
        options[:help] ? (return puts 'Acceda a https://kramdown.gettalong.org/quickref.html para información sobre la sintaxis de Markdown') : ()
        options[:book] ? (
            book = RN::Models::Book.new ARGV[-1]
            title = ARGV[-3]) :
            (book = RN::Models::Book.new ""
            title = ARGV[-1])

        note = RN::Models::Note.open title,book
        note.export

        puts "Nota exportada con éxito!"
        rescue RN::Exceptions::ExcepcionesModelo => e
            puts e.message
        end
    end
end