module RN::Commands::Notes
    class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, desc: 'List only notes from the global book'

        include Paths

        def call(**options)
          # el codigo del final de archivo no funcionaba -> duda
          # esta solución es poco objetosa y no es escalable, le falta recursión -> SUPER VER!

          puts Dir.glob("#{self.root}/*").select {|file| File.file?(file)}.map {|note| note.split("/")[-1]} if options[:global]
          puts Dir["#{self.path(ARGV[-1])}/*"].map {|note| note.split("/")[-1]} if self.exists(self.path(ARGV[-1]))
          if options == {}
            Dir.glob("#{self.root}/*").map do |folder|
              puts Dir["#{folder}/*"].map {|note| note.split("/")[-1]} if !File.file?(folder)
              puts folder.split("/")[-1] if File.file?(folder)
            end
          end
        end
    end

end

# ((( LIST CLASS )))
# NO FUNCION
# options[:book] && self.exists(self.path(ARGV[-1])) ? puts Dir.glob("#{self.path(ARGV[-1])}/*").map {|path| path.split("/")[-1]} : warn "No existe el cuaderno ingresado"
# puts Dir.glob("#{self.root}/*").select {|file| File.file?(file)}.map {|note| note.split("/")[-1]} if options[:global]
#
# TAMPOCO ACÁ, NUNCA ENTRA EN EL WHEN DEL MEDIO
# case options
# when{}
#   Dir.glob("#{self.root}/*").map do |folder|
#     puts Dir["#{folder}/*"].map {|note| note.split("/")[-1]} if !File.file?(folder)
#     puts folder.split("/")[-1] if File.file?(folder)
#   end
# when :book
#   puts self.path
#   if self.exists(self.path(ARGV[-1]))
#     puts Dir["#{self.path(ARGV[-1])}/*"].map {|note| note.split("/")[-1]}
#   else warn "El cuaderno ingresado no existe" end
# else :global
#   puts Dir.glob("#{self.root}/*").select {|file| File.file?(file)}.map {|note| note.split("/")[-1]}
# end