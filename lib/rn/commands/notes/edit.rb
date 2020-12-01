module RN::Commands::Notes
    class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        include Paths
        include Notes


        def call(title:, **options)
          # Ya q utilicé la gema tty-editor, tanto las clases (comandos) Show como Edit funcionan igual.
          # Debido a esto decidí crear una función de mi módulo Note, con el solo objetivo de
          # no repetir muchas líneas de código

          options[:book] ? book = self.path(ARGV[-1]) : book = self.root
          self.show_and_edit(title, book)

        end
    end
end