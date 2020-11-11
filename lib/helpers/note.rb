require 'fileutils'
require_relative '../helpers/paths'

module Note
    include Paths

    def extention(title)
        "/#{title}.rn"
    end

    def validate_bookname(name)
        if name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
            puts "No puede incluir símbolos en el nombre del cuaderno"
            false
        else true end
    end

    def validate_rename_note_in_book(book, new_title, old_title)
        return warn "El cuaderno ingresado no existe" if !self.exists(book)
        return warn "La nota ingresada no existe en el cuaderno" if !self.exists(book+self.extention(old_title))
        return warn "Ya existe una nota con el renombre ingresado en el cuaderno" if !self.exists(book+self.extention(new_title))
    end



end
