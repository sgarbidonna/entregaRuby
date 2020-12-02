module RN::Models
    class Book
        attr_accessor :title, :root, :path

        singleton_class.send(:alias_method, :open, :new)

        def initialize(title)
            self.title = title
            self.root = "#{Dir.home}/my_rns"
            self.path = self.root+'/'+title
        end

        def self.root
            Dir.glob("#{Dir.home}/my_rns/")
        end

        def self.list
            Dir.glob("#{Dir.home}/my_rns/*").map {|path| path.split("/")[-1]}
        end

        def self.list_books
            Dir.glob("#{Dir.home}/my_rns/*").select {|file| File.directory?(file)}.map {|path| path.split("/")[-1]}
            # devuelve los cuadernos
        end

        def self.list_root_notes
            Dir.glob("#{Dir.home}/my_rns/*").select {|file| File.file?(file)}.map {|path| path.split("/")[-1]}
            # devuelve las notas del root
        end

        def self.list_book_notes(book_name)
            Dir.glob("#{Dir.home}/my_rns/#{}*").select {|file| File.file?(file)}.map {|path| path.split("/")[-1]}
            # devuelve las notas del root
        end

        def self.list_all
            notes = self.list_root_notes
            notes << self.list_books.map { |book_name|
                book = RN::Models::Book.new book_name
                book.list_notes
            }
            notes
            #devuelve todas las notas
        end

        def self.delete_notes
            self.validate_existence_notes
            self.list_root_notes.each { |note_name|
                FileUtils.remove_entry_secure( self.root[0] + note_name)
            }

        end

        def self.exports_path
            FileUtils.mkdir_p self.root[0]+'exports'
        end

        def self.exports_book_in(title)
            title == "" ? (path = self.root[0]+'exports/') : (path = self.root[0]+'exports/'+title+'/')
            FileUtils.mkdir_p path
            path
        end

        def self.export_root
            book = RN::Models::Book.open ""
            notes = self.list_root_notes.map {|path| path.split(".")[-2]}
            notes.each { |note_name|
                note = RN::Models::Note.open(note_name, book)
                note.export
            }
        end

        def self.export_books
            notes = self.list_books
            notes.each { |book_name|
                book = RN::Models::Book.open book_name
                book.export_notes
            }

        end

        def self.export_all
            self.export_root
            self.export_books
        end

        def export_notes
            my_notes = list_notes.map {|path| path.split(".")[-2]}
            my_notes.each { |note_name|
                note = RN::Models::Note.new(note_name,self)
                note.export
            }
        end

        def create
            validate_uniqueness
            validate_title
            FileUtils.mkdir_p path
        end

        def remove
            if title != 'root'
                validate_existence if title != 'root'
                FileUtils.remove_entry_secure path  if title != 'root'
                "Acaba de eliminar el cuaderno '#{title.upcase}' y todas las notas allí contenidas"
            else
                FileUtils.rm_rf(Dir.glob("#{Dir.home}/my_rns/*")) if title == 'root'
                "Acaba de eliminar el cuaderno global y todas las notas allí contenidas"
            end
        end

        def rename(newB)
            validate_existence
            newB.validate_title
            newB.validate_uniqueness

            FileUtils.mv path, newB.path

            self.title = newB.title
            self.path = newB.path

        end

        def list_notes
            title == "" ? ( Dir.glob(path+"*").select {|file| File.file?(file)}.map {|note| note.split("/")[-1]}) :
            (Dir.glob(path+"/*").select {|file| File.file?(file)}.map {|note| note.split("/")[-1]})
        end

        def exists?
            title != "" ? (Dir.exist? path ): true #|| File.file? path # File.file?, File.exists? y File.exist? funcionan mal
        end

        def validtitle?(name=nil)
            name.nil? ? title.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/) : name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
        end

        def validate_title(name=nil)
            raise RN::Exceptions::NombreInvalido, "El nombre no puede incluir símbolos" if validtitle? name
        end

        def validate_existence
            raise RN::Exceptions::Inexistente, "El nombre de cuaderno '#{title}' no existe" unless exists?
        end

        def self.validate_existence_notes
            raise RN::Exceptions::NotasInexistentes, "No existen notas en el directorio raíz" if self.list_root_notes.empty?
        end

        def validate_uniqueness
            raise RN::Exceptions::ExisteIdentico, "El nombre del cuaderno ya existe" if exists? unless title==""
        end



    end
end