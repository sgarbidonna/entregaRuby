class Book
    attr_accessor :title :root :path

    singleton_class.send(:alias_method, :open, :new)

    def initialize(title)
        self.title = title
        self.root = "#{Dir.home}/my_rns"
        self.path = self.root+'/'+name
    end

    def validate(name)
        (return warn "El nombre del cuaderno ya existe") if self.exists(self.path(name))
        (return warn "El nombre no puede incluir símbolos") if name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
        true
    end

    def exists(name)
        Dir.exist?(name) || File.file?(name) # File.file?, File.exists? y File.exist? funcionan mal
    end
end