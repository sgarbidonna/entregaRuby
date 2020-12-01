module RN::Commands::Notes
  class List < Dry::CLI::Command
    desc 'List notes'

    option :book, type: :string, desc: 'Book'
    option :global, type: :boolean, desc: 'List only notes from the global book'

    def call(**options)

      options[:book] ? (book = RN::Models::Book.new ARGV[-1]) : ()
      options[:global] ? (book = RN::Models::Book.new "") : ()
      options == {} ? (book = nil) : ()

      list = RN::Models::Note.list book

      list.empty? ? (puts "No existe ninguna nota" ) : (puts list)
    end
  end

end
