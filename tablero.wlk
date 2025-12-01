import elementos.*
import escenas.*
import extras.*
import molly.*
import wollok.game.*

object tablero {

    method lindantesDelMismoTipo(unaCosa, unaDireccion) { // Devuelve los objetos lindante a la direccion dada del mismo tipo que se le pide al parametro
        const posicionCosa = unaCosa.position()
        const filtrado = game.getObjectsIn(unaDireccion.siguiente(posicionCosa))
        filtrado.remove(molly)
        return filtrado.filter({obj => obj.tipo() == unaCosa.tipo()})
    }

    method cosaLindante(unaCosa) { // Devuelve la cosa dada la cantidad de veces que apariciones en direcciones
        const dir = [arriba,abajo,der,izq]
        const acumulador = []
        dir.forEach({unaDireccion => self.agregarCosaSiExiste(acumulador, unaDireccion, unaCosa)})
        return acumulador
    }

    method cosasEnLindantesDe(unaCosa) {  // Devuelve las cosas que estan en las direcciones lindantes de la cosa dada
        const dir = [arriba,abajo,der,izq]
        const acumulador = []
        dir.forEach({unaDireccion => self.agregarSiExiste(acumulador, unaDireccion, unaCosa)})
        return acumulador
    }

    method agregarSiExiste(unaLista, unaDireccion, unaCosa){ // Agrega la cosa dada a la lista si está en la direccion dada
        const posicionCosa = unaCosa.position()
        const cosaEnDir = game.getObjectsIn(unaDireccion.siguiente(posicionCosa))
        if (not cosaEnDir.isEmpty()){
            unaLista.add(cosaEnDir.uniqueElement())
        }
    }

    method agregarCosaSiExiste(unaLista, unaDireccion, unaCosa) {  // Agrega la cosa dada a la lista si es el mismo tipo
        const acumulador = []
        if (not self.lindantesDelMismoTipo(unaCosa, unaDireccion).isEmpty()){
            unaLista.add(self.lindantesDelMismoTipo(unaCosa, unaDireccion).first())
        }
    }

    method validarMoverse(unaCosa, direccion) { //mismo metodo, solo que hay q pasar unaCosa como parametro
        const bordeIzq = unaCosa.position().x() == 0                
        const bordeDer = unaCosa.position().x() >= game.width()-7 
        const objetoDir = game.getObjectsIn(direccion.siguiente(unaCosa.position()))                 
        if (bordeIzq || bordeDer || not objetoDir.isEmpty()){                              
            self.error("")                                                                 
        } 
    }

    method objetoLindanteEnCelda(direccion, position) {  // Retorna la lista de objetos en la celda lindante
        return game.getObjectsIn(direccion.siguiente(
            game.at(position.x(), (position.y() / 7).truncate(0) * 7))) // Cálculo que divide bien las celdas
    }

    method objetosEn(direccion, position){  // Retorna la lista de objetos que esta en la direccion dada desde la posicion
        return game.getObjectsIn(direccion.siguiente(position))  
    }
}
