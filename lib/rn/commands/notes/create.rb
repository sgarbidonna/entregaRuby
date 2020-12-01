module RN::Commands::Notes
    class Create < Dry::CLI::Commands
        desc 'Create a note'


        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        include Notes
        include Paths

        def call(title:, **options)
          options[:book] ? book = self.path(ARGV[-1]) : book = self.root

          if self.general_validations(book, title)
              FileUtils.mkdir_p(book) if !self.exists(book)
              File.new(book+self.extention(title),'w')
              warn "La nota '#{title.upcase}' se creó exitosamente)"
          end
    end

end