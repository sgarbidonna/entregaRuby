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
          if options[:book]
            if self.validate_bookname(ARGV[-1])
              FileUtils.mkdir_p self.path(ARGV[-1]) if !self.exists(self.path(ARGV[-1]))
              if !self.exists(self.path(ARGV[-1])+self.extention(title))
                File.new(self.path(ARGV[-1])+self.extention(title),'w')
                warn "La nota '#{title.upcase}' se creó exitosamente, en el cuaderno '#{ARGV[-1].upcase}'"
              else warn "La nota ya existía en el cuaderno '#{ARGV[-1].upcase}' " end
            end
          elsif !self.exists(self.root+self.extention(title))
              File.new(self.root+self.extention(title),'w')
              warn "La nota '#{title.upcase}' se creó exitosamente en el cuaderno raíz"
          else warn "La nota ya existía"
          end

        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          if !self.exists(book)
            warn "El cuaderno ingresado no existe"
            return false
          elsif !self.exists(book+self.extention(old_title))
            warn "La nota ingresada no existe en el cuaderno"
            return false
          elsif self.exists(book+self.extention(new_title))
            warn "Ya existe una nota con el renombre ingresado en el cuaderno"
            return false
          else
            File.rename(book+self.extention(old_title),book+self.extention(new_title))
            warn "Renombre exitoso"
          end

          #  NO  SE  POR QUÉ  NO  FUNCIONA  LA  VALIDACION !!
          # path=""
          # if options[:book] && self.validate_rename_note_in_book(self.path(ARGV[-1]),old_title,new_title)
          #   path = self.path(ARGV[-1])
          # elsif !options[:book] && self.validate_rename_note_in_book(self.root,old_title,new_title)
          #   path = self.root
          # end
          # if !path.empty?
          #   File.rename(path+self.extention(old_title),path+self.extention(new_title))
          #   warn "Renombre exitoso"
          # end

        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, desc: 'List only notes from the global book'

        include Paths

        def call(**options)
          # el codigo del final de archivo no funcionaba -> duda

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

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          puts self.root+self.extention(title)
          # File.open(self.root+self.extention(title))
          TTY::Editor.open(self.root+self.extention(title))
          warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end



          # LIST CLASS
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