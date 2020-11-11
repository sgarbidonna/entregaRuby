module Paths

    def root()
        return "#{Dir.home}/my_rns"
    end

    def path(name)
        return "#{Dir.home}/my_rns/#{name}"
    end

    def validate(name)
        if self.exists(name)
            puts "El nombre del cuaderno ya existe"
            false
        elsif name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
            # elsif name.match(/\W/)
            puts "No puede incluir símbolos en el nombre del cuaderno"
            false
        else true
        end
    end



    def exists(name) #inicializacion de books para que no tire error cuanod creo un cuaderno
        Dir.exist?(name) || File.file?(name)
    end

end
