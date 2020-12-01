module RN::Commands::Notes

    class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        include Paths
        include Notes

        def call(old_title:, new_title:, **options)

          options[:book] ? book = self.path(ARGV[-1]) : book = self.root
          if self.validate_retitle_a_note(book, new_title, old_title)
            File.rename(book+self.extention(old_title),book+self.extention(new_title))
            warn "Renombre exitoso"
          end


        end
    end
end