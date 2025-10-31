class ProfesionalVinculado {
    const property universidad


    method provinciasDondePuedeTrabajar() = [universidad.provincia()]

    method honorarios() {
        return universidad.honorarios()
    } 

    method cobrar(importe) {
        universidad.recibirDonacion(importe / 2)
    }
}

class ProfesionalAsociado {
    const property universidad

    const property provinciasDondePuedeTrabajar = ["Entre Rios, Santa Fe, Corrientes"]

    method honorarios() = 3000

    method cobrar(importe) {
        AsociacionProfesionalesLitoral.recibirAporte(importe)
    }
}

object AsociacionProfesionalesLitoral {
    var totalRecaudado = 0

    method recibirAporte(monto) {
        totalRecaudado += monto
    }
}


class ProfesionalLibre {
    const property universidad
    const property provinciasDondePuedeTrabajar
    const property honorarios
    var totalRecaudado = 0   

    method cobrar(importe) {
        totalRecaudado += importe
    }

    method pasarDinero(otroProfesional, monto) {
        totalRecaudado -= monto
        otroProfesional.cobrar(monto)
    }
}
 
class Universidad {
    const property provincia
    const property honorarios
    var totalDonado = 0

    method recibirDonacion(monto) {
        totalDonado += monto
    }
}

class Empresa {
    const property profesionalesContratados = [] 
    const property honorarios
    var clientes = #{}

    method cantidadProfesionalesQueEstudiaronEn(unaUniversidad) {
        return profesionalesContratados.count({p => p.universidad() == unaUniversidad})
    }

    method profesionalesCaros() {
        return profesionalesContratados.filter({p => p.honorarios() > self.honorarios()})
    }

    method universidadesFormadoras() {
        return (profesionalesContratados.map({p => p.universidad()})).asSet()
    }

    method profesionalMasBarato() {
        return profesionalesContratados.min({p => p.honorarios()})
    }

    method esDeGenteAcotada() {
        return not profesionalesContratados.any({p => p.provinciasDondePuedeTrabajar().size() > 3})
    }

    method puedeSatisfacerA(unSolicitante) {
        return profesionalesContratados.any({p => unSolicitante.puedeSerAtendidoPor(p)})
    }


    method darServicio(unSolicitante) {
        if (self.puedeSatisfacerA(unSolicitante)) {
            const profesionalElegido = profesionalesContratados.find({p => 
                unSolicitante.puedeSerAtendidoPor(p)})
            profesionalElegido.cobrar(profesionalElegido.honorarios())
            clientes.add(unSolicitante)
        }
    }

    method cantidadClientes() {
        return clientes.size()
    }

    method tieneComoCliente(unSolicitante) {
        return clientes.contains(unSolicitante)
    }

    method esPocoAtractivo(unProfesional) {
    return unProfesional.provinciasDondePuedeTrabajar().all({provincia =>
        profesionalesContratados.any({otroProfesional =>
            otroProfesional != unProfesional and
            otroProfesional.provinciasDondePuedeTrabajar().contains(provincia) and
            otroProfesional.honorarios() < unProfesional.honorarios()
        })
    })
}

}