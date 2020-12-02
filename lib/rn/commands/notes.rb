module RN::Commands
  module Notes
    autoload :Create, "rn/commands/notes/create"
    autoload :Delete, "rn/commands/notes/delete"
    autoload :Edit, "rn/commands/notes/edit"
    autoload :List, "rn/commands/notes/list"
    autoload :Retitle, "rn/commands/notes/retitle"
    autoload :Show, "rn/commands/notes/show"
    autoload :Export, "rn/commands/notes/export"
  end

end