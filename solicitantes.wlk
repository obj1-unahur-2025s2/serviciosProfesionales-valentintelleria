import profesionalesYEmpresas.*

class Solicitante {
    const property tipo
    
    method puedeSerAtendidoPor(unProfesional) {
        return tipo.puedeSerAtendidoPor(unProfesional)
    }
}

class Persona {
    const provincia

    method puedeSerAtendidoPor(unProfesional) {
        return unProfesional.provinciasDondePuedeTrabajar().contains(provincia)
    }
}

class Institucion {
    const universidades = []

    method puedeSerAtendidoPor(unProfesional) {
        return universidades.contains(unProfesional.universidad())
    }
}

class Club {
    const property provincias = []

    method puedeSerAtendidoPor(unProfesional) {
        return provincias.any({p => unProfesional.provinciasDondePuedeTrabajar().contains(p)
        })
    }
}
