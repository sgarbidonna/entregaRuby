require 'fileutils'
require_relative '../../helpers/note'
require_relative '../../helpers/paths'

module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Create a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        include Note
        include Paths

        def call(title:, **options)
          options[:book] ? book = self.path(ARGV[-1]) : book = self.root
          !self.exists(book) ? (self.validate_bookname(ARGV[-1]) ? (FileUtils.mkdir_p(book)) : "") : ""
          if !self.exists(book+self.extention(title))
                File.new(book+self.extention(title),'w')
                warn "La nota '#{title.upcase}' se creó exitosamente)"
          else warn "La nota ya existía en el cuaderno " end

        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        include Paths
        include Note

        def call(title:, **options)
          options[:book] ? book = self.path(ARGV[-1]) : book = self.root
          FileUtils.remove_entry_secure book+self.extention(title)
          warn "Nota eliminada"
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        include Paths
        include Note


        def call(title:, **options)
          # Ya q utilicé la gema tty-editor, tanto las clases (comandos) Show como Edit funcionan igual.
          # Debido a esto decidí crear una función de mi módulo Note, con el solo objetivo de
          # no repetir muchas líneas de código
          self.show_or_edit(title, options[:book])

        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        include Paths
        include Note

        def call(old_title:, new_title:, **options)

          options[:book] ? book = self.path(ARGV[-1]) : book = self.root
          if self.validate_rename_a_note(book, new_title, old_title)
            File.rename(book+self.extention(old_title),book+self.extention(new_title))
            warn "Renombre exitoso"
          end


        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, desc: 'List only notes from the global book'

        include Paths

        def call(**options)
          # el codigo del final de archivo no funcionaba -> duda
          # solución poco objetosa y no recursiva -> SUPER VER!
          puts Dir.glob("#{self.root}/*").select {|file| File.file?(file)}.map {|note| note.split("/")[-1]} if options[:global]
          puts Dir["#{self.path(ARGV[-1])}/*"].map {|note| note.split("/")[-1]} if self.exists(self.path(ARGV[-1]))
          if options == {}
            Dir.glob("#{self.root}/*").map do |folder|
              puts Dir["#{folder}/*"].map {|note| note.split("/")[-1]} if !File.file?(folder)
              puts folder.split("/")[-1] if File.file?(folder)
            end
          end
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        include Paths
        include Note

        def call(title:, **options)
          # options = [] unless options[:book]
          self.show_or_edit(title, options[:book])
        end


      end
    end
  end
end



          # ((( LIST CLASS )))
          # NO FUNCION
          # options[:book] && self.exists(self.path(ARGV[-1])) ? puts Dir.glob("#{self.path(ARGV[-1])}/*").map {|path| path.split("/")[-1]} : warn "No existe el cuaderno ingresado"
          # puts Dir.glob("#{self.root}/*").select {|file| File.file?(file)}.map {|note| note.split("/")[-1]} if options[:global]
          #
          # TAMPOCO ACÁ, NUNCA ENTRA EN EL WHEN DEL MEDIO
          # case options
          # when{}
          #   Dir.glob("#{self.root}/*").map do |folder|
          #     puts Dir["#{folder}/*"].map {|note| note.split("/")[-1]} if !File.file?(folder)
          #     puts folder.split("/")[-1] if File.file?(folder)
          #   end
          # when :book
          #   puts self.path
          #   if self.exists(self.path(ARGV[-1]))
          #     puts Dir["#{self.path(ARGV[-1])}/*"].map {|note| note.split("/")[-1]}
          #   else warn "El cuaderno ingresado no existe" end
          # else :global
          #   puts Dir.glob("#{self.root}/*").select {|file| File.file?(file)}.map {|note| note.split("/")[-1]}
          # end