require 'fileutils'
require_relative '../helpers/paths'

module Notes
    include Paths

    def extention(title)
        "/#{title}.rn"
    end

    def show_and_edit(title,book=[])

        !self.exists(book) ? (return warn "No existe el cuaderno seleccionado") :
        self.exists(self.path(ARGV[-1])+self.extention(title)) ? TTY::Editor.open(self.path(ARGV[-1])+self.extention(title)) : (return warn "No existe la nota o te equivocaste de cuaderno :)")

    end

    def general_validations(book, name)
        (return warn "No puede incluir símbolos en el nombre del cuaderno") if name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
        (return warn "Ya existe una nota con el renombre ingresado en el cuaderno") if self.exists(book+self.extention(name))
        true
    end


    def validate_retitle_a_note(book, new_title, old_title)
        if self.general_validations(book,new_title)
            (return warn "El cuaderno ingresado no existe") if !self.exists(book)
            (return warn "La nota ingresada no existe en el cuaderno") if  !self.exists(book+self.extention(old_title))
            true
        end
    end



end





# metodos q igual no anduvieron pero quiero mantener para ver luego
# FORMA 1
# def validate_rename_note_in_book(book, new_title, old_title)
#     puts book, new_title,old_title
#     (return warn "El cuaderno ingresado no existe" && false) if !self.exists(book)
#     (return warn "La nota ingresada no existe en el cuaderno" && false) if !self.exists(book+self.extention(old_title))
#     (return warn "Ya existe una nota con el renombre ingresado en el cuaderno" && false) if self.exists(book+self.extention(new_title))
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

# # FORMA 3
# def validate_rename_note_in_book_msgs(book, new_title, old_title)
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






