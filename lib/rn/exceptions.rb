module RN
    module Exceptions
        class ExcepcionesModelo < Exception; end
        class ExisteIdentico < ExcepcionesModelo; end
        class NombreInvalido < ExcepcionesModelo; end
        class Inexistente < ExcepcionesModelo; end
        class NotasInexistentes < ExcepcionesModelo; end

    end
  end
