module RN::Commands::Notes
  class Retitle < Dry::CLI::Command
    desc 'Retitle a note'

    argument :old_title, required: true, desc: 'Current title of the note'
    argument :new_title, required: true, desc: 'New title for the note'
    option :book, type: :string, desc: 'Book'

    def call(old_title:, new_title:, **options)

      options[:book] ? (book = RN::Models::Book.new ARGV[-1]) : (book = RN::Models::Book.new "")
      
      oldN = RN::Models::Note.open old_title,book
      newN = RN::Models::Note.open new_title,book
      oldN.retitle newN
      
      puts "El antiguo cuaderno de nombre '#{old_title.upcase}' pasó a llamarse '#{new_title.upcase}'."
    rescue RN::Exceptions::ExcepcionesModelo => e
        warn e.message
    end
  end
end