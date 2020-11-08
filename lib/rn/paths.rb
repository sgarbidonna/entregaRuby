module Paths

    def root()
        return "#{Dir.home}/my_rns"
    end

    def path(name)
        return "#{Dir.home}/my_rns/#{name}"
    end

    # def getNotesPaths()
    #     return Dir.entries(self.root)
    # end
end
