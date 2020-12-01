module RN::Models
    class Book
        attr_accessor :title, :root, :path

        singleton_class.send(:alias_method, :open, :new)

        def initialize(title)
            self.title = title
            self.root = "#{Dir.home}/my_rns"
            self.path = self.root+'/'+title
        end

        def self.list
            Dir.glob("#{Dir.home}/my_rns/*").map {|path| path.split("/")[-1]}
        end
        # def self.all
        #     list.map do |book_title|
        #         Book.open(book_title)
        #     end
        # end

        def create
            validate_uniqueness
            validate_title
            FileUtils.mkdir_p path
        end

        def remove
            validate_existence if title != 'root'
            FileUtils.remove_entry_secure path  if title != 'root'
            FileUtils.rm_rf(Dir.glob("#{Dir.home}/my_rns/*")) if title == 'root'
        end

        def rename(new_name)
            validate_existence
            validate_title new_name

            new_path= root+'/'+new_name
            FileUtils.mv path, new_path

            self.title = new_name
            self.path = new_path

        end

        def exists?
            Dir.exist? path #|| File.file? path # File.file?, File.exists? y File.exist? funcionan mal
        end

        def validtitle?(name=nil)
            name.nil? ? title.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/) : name.match(/[!?¿@#$%^&*(=)_+{}\[\]:;'"\/\\?><.,]/)
        end

        def validate_title(name=nil)
            raise RN::Exceptions::NombreInvalido, "El nombre no puede incluir símbolos" if validtitle? name
        end

        def validate_existence
            raise RN::Exceptions::Inexistente, "El nombre de cuaderno '#{title}' no existe" unless exists?
        end

        def validate_uniqueness
            raise RN::Exceptions::ExisteIdentico, "El nombre del cuaderno ya existe" if exists?
        end



    end
end