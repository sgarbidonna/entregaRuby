module RN::Commands::Books
    class Export < Dry::CLI::Command
      desc 'Export notes from the sleected book'

      option :book, type: :string, desc: 'Exports all notes contened in a given book'
      option :all, type: :boolean , desc: 'Exports all notes contened in global book'

      def call(**options)
        options[:book] ? (book=RN::Models::Book.new ARGV[-1]) : (book=RN::Models::Book.new "")
        options[:all] ? (all=true) : (all=false)

        all ? (RN::Models::Book.export_all) : (book.export_notes)
        puts "Se exportaron las notas"

      rescue RN::Exceptions::ExcepcionesModelo => e
        warn e.message
      end
    end

end