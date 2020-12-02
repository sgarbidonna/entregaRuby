module RN::Commands::Books
    class Export < Dry::CLI::Command
      desc 'Export notes from the sleected book'

      option :book, type: :string, desc: 'Exports all notes contened in a given book'
      option :all, type: :boolean , desc: 'Exports all notes contened in global book'

      def call(**options)

        list = (
        options[:book] ? ( book=RN::Models::Book.open ARGV[-1]) : (book=RN::Models::Book.open "")
        options[:all] ? (RN::Models::Book.export_all) : (book.export_notes))

        list.empty? ? (puts "No hubo notas que exportar") :(puts "Se exportaron las notas correctamente")
      rescue RN::Exceptions::ExcepcionesModelo => e
        warn e.message
      end
    end

end