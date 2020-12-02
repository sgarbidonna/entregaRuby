module RN::Models
    class Note
        attr_accessor :title, :path, :book, :extention

        singleton_class.send(:alias_method, :open, :new)

        def initialize(title,book_instance)
            self.title = title
            self.book = book_instance
            self.extention = '.rn'
            book.title == "" ? (self.path = book.path + title + extention) : (self.path = book.path + "/" + title + extention)
        end

        def self.list(book)
            book == nil ? (RN::Models::Book.list_all) : (book.list_notes)
        end

        def create
            validate_title
            validate_uniqueness
            book.create if !book.exists?
            File.new(path,'w')
        end

        def show_and_edit
            !book.exists? ? (return warn "No existe el cuaderno seleccionado") :
            validate_existence
            TTY::Editor.open(path)

        end

        def retitle(newN)
            validate_existence

            newN.validate_title
            newN.validate_uniqueness


            File.rename(path, newN.path)
            self.title = newN.title
            self.path = newN.path
        end

        def delete(global)
            if !global
                validate_existence
                FileUtils.remove_entry_secure(path)
            else RN::Models::Book.delete_notes end
        end

        def export
            validate_existence

            content = (File.open path).read
            formatted_text = Kramdown::Document.new(content).to_html

            export_book_path = RN::Models::Book.exports_book_in(book.title)
            path = export_book_path + title + ".html"

            File.write(path , formatted_text)
        end

        def validtitle?(name=nil)
            name.nil? ? title.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/) : name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
        end

        def validate_title(name=nil)
            raise RN::Exceptions::NombreInvalido, "El nombre no puede incluir símbolos" if validtitle? name
        end

        def exists?
            File.file? path
        end

        def validate_uniqueness
            raise RN::Exceptions::ExisteIdentico, "Ya existe una nota con el nombre ingresado en el cuaderno" if exists?
        end

        def validate_existence
            raise RN::Exceptions::Inexistente, "No existe la nota '#{title.upcase}', o te equivocaste de cuaderno :)" unless exists?
        end

        def valid_format?(format)
            extention.match? /pdf|html|rn/
        end

        def validate_format(format)
            raise RN::Exceptions::FormatoInvalido, "Los formatos admitibles son '.rn', '.pdf' y '.html' " unless valid_format? format
        end
    end
end