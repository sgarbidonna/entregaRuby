module RN::Commands
  module Books
    autoload :Create, "rn/commands/books/create"
    autoload :Delete, "rn/commands/books/delete"
    autoload :List, "rn/commands/books/list"
    autoload :Rename, "rn/commands/books/rename"
    autoload :Export, "rn/commands/books/export"
  end

end
