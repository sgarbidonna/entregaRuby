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


    # FORMA 1
    # def validate_rename_note_in_book(book, new_title, old_title)
    #     warn "El cuaderno ingresado no existe" && false if !self.exists(book)
    #     warn "La nota ingresada no existe en el cuaderno" && false if !self.exists(book+self.extention(old_title))
    #     warn "Ya existe una nota con el renombre ingresado en el cuaderno" && false if self.exists(book+self.extention(new_title))
    #     true
    # end

    # FORMA 2
    # def validate_rename_note_in_book_msgs(book, new_title, old_title)
    #     msg=""
    #     !self.exists(book) ? msg+"El cuaderno ingresado no existe" : ""
    #     !self.exists(book+self.extention(old_title)) ? msg+"La nota ingresada no existe en el cuaderno" : ""
    #     self.exists(book+self.extention(new_title)) ? msg+"Ya existe una nota con el renombre ingresado en el cuaderno" : ""
    #     msg.empty? ? return true : return msg
    # end

    # FORMA 3
    # def validate_rename_note_in_book(book, new_title, old_title)
    #     return "El cuaderno ingresado no existe" if !self.exists(book)
    #     return "La nota ingresada no existe en el cuaderno" if !self.exists(book+self.extention(old_title))
    #     return "Ya existe una nota con el renombre ingresado en el cuaderno" if self.exists(book+self.extention(new_title))
    # end
    # def validate_rename_note_in_book(book, new_title, old_title)
    #     msg = self.validate_rename_note_in_book_msgs(book, new_title, old_title)
    #     if msg
    #         puts msg
    #     else true
    #     end
    # end


end
