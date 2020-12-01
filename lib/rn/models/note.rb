class Note
    attr_accessor :title, :path, :book, :extention, :text

    singleton_class.send(:alias_method, :open, :new)

    def initialize title


    end

    def extention(extention='rn')
        "/#{title}.#{extention}"
    end

    def create(book)
        validate_title
        validate_uniqueness
        book.validate_existance

        book.create if !book.validate_existance
        File.new(book.path + extention,'w')

    end


    def validtitle?(name=nil)
        name.nil? ? path.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/) : name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
    end

    def validate_title(name=nil)
        raise RN::Exceptions::NombreInvalido, "El nombre no puede incluir símbolos" if validtitle? name
    end

    def validate_uniqueness
        raise RN::Exceptions::ExisteIdentico, "Ya existe una nota con el renombre ingresado en el cuaderno" if exists?
    end
end