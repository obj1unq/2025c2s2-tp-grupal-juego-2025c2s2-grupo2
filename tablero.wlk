import comidas.*
import escenas.*
import extras.*
import molly.*
import wollok.game.*

object tablero {

    method lindantesEn(unaComida, unaDireccion) { //mismo metodo, solo que hay q pasar unaComida como parametro
        const posicionComida = unaComida.pos()
        const filtrado = game.getObjectsIn(unaDireccion.siguiente(posicionComida))
        if (filtrado.any({obj => obj.kindName() != unaComida.kindName()})){          //arreglar
            filtrado.remove(filtrado.find({obj => obj.kindName() != unaComida.kindName()}))
        }
        return filtrado
    }

    method lindantes(unaComida) { //mismo metodo, solo que hay q pasar unaComida como parametro 
        const dir = [arriba,abajo,der,izq]
        const acumulador = []
        dir.forEach({unaDireccion => self.agregarSiExiste(acumulador, unaDireccion, unaComida)})
        return acumulador
    }

    method agregarSiExiste(unaLista, unaDireccion, unaComida) {  //mismo metodo, solo que hay q pasar unaComida como parametro
        const acumulador = []
        if (not self.lindantesEn(unaComida, unaDireccion).isEmpty()){
            unaLista.add(self.lindantesEn(unaComida, unaDireccion).first())
        }
    }

    method validarMoverse(unaComida, direccion) { //mismo metodo, solo que hay q pasar unaComida como parametro
        const bordeIzq = unaComida.position().x() == 0                
        const bordeDer = unaComida.position().x() >= game.width()-10 
        const objetoDir = game.getObjectsIn(direccion.siguiente(unaComida.position()))                 
        if (bordeIzq || bordeDer || not objetoDir.isEmpty()){                              
            self.error("")                                                                 
        } 
    }
}
