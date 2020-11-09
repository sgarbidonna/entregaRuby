module Paths

    def root()
        return "#{Dir.home}/my_rns"
    end

    def path(name)
        return "#{Dir.home}/my_rns/#{name}"
    end

    def validate(name)
        if Dir.exist?("#{Dir.home}/my_rns/#{name}") then
            puts "El nombre del cuaderno ya existe"
            return false
        elsif name.match(/[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/) then
            puts "No puede incluir símbolos en el nombre del cuaderno"
            return false
        else return true
        end
    end

    def exists(name)
        if Dir.exist?("#{Dir.home}/my_rns/#{name}") then return true end
    end
end
