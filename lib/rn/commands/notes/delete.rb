module RN::Commands::Notes
    class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        include Paths
        include Notes

        def call(title:, **options)
          options[:book] ? book = self.path(ARGV[-1]) : book = self.root
          self.exists(book+self.extention(title)) ? (FileUtils.remove_entry_secure(book+self.extention(title)) && (warn "Nota eliminada")) : (warn "La nota no existe")
        end
    end
end