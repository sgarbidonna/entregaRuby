module RN
    module Exceptions
        class ExcepcionesModelo < Exception; end
        class ExisteIdentico < ExcepcionesModelo; end
        class NombreInvalido < ExcepcionesModelo; end
        class Inexistente < ExcepcionesModelo; end
    #   class MissingNote < ExcepcionesModelo; end
    #   class MissingBook < ExcepcionesModelo; end
    #   class InvalidFormat < ExcepcionesModelo; end
    end
  end
