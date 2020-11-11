module Paths

    def root()
        return "#{Dir.home}/my_rns"
    end

    def path(name)
        return self.root+'/'+name
    end

    def validate(name)
        (return warn "El nombre del cuaderno ya existe") if self.exists(self.path(name))
        (return warn "No puede incluir símbolos en el nombre del cuaderno") if name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
        true
    end

    def exists(name)
        Dir.exist?(name) || File.file?(name) # File.file?, File.exists? y File.exist? funcionan mal
    end

end
