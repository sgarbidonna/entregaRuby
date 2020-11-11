module Paths

    def root()
        return "#{Dir.home}/my_rns"
    end

    # def path(name)
    #     return "#{Dir.home}/my_rns/#{name}"
    # end

    def path(name)
        return self.root+'/'+name
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



    def exists(name)
        Dir.exist?(name) || File.file?(name) # File.file?, File.exists? y File.exist? funcionan mal
    end

end
