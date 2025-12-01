import wollok.game.*
import extras.*
import elementos.*
import escenas.*
import tablero.*

object molly {
    var property mirandoA = der //para cambiar imagen dependiendo a donde este mirando cuando se mueve derecha o izquierda
    var property position = game.at(0, 0)
    var property vidas = corazones.list()
    var property puntos = 0

    method image() = "molly-" + mirandoA.nombreDir() + ".png"

    method vidasRestantes(){
        return vidas.filter({vida => vida.estaFeliz()}).size()
    }

    method moverse(direccion) {
        mirandoA = direccion // Cambia el sprite de molly hacia la direccion donde se mueve
        self.validarMoverse(direccion)
        position = direccion.siguiente(position)
    }

    method validarMoverse(direccion) {
        self.validarSalirBordes(direccion)
        if (not tablero.objetoLindanteEnCelda(direccion, position).isEmpty()){ // Indica si quiere salirse del borde izquierdo, derecho, y si hay un objeto en donde me quiero mover
            self.error("")   // String vacio significa que no se mueve!
        }
                 
    }

    method validarSalirBordes(direccion){
        const bordeIzq = self.position().x() == 0 && izq.estaMirandoMolly()                
        const bordeDer = self.position().x() >= game.width()-10 && der.estaMirandoMolly() 
        if ((bordeIzq && direccion.nombreDir() == "izq") || (bordeDer && direccion.nombreDir() == "der")){                              
            self.error("")   // String vacio significa que no se mueve!                                                              
        }
    }

    method saltar() {
        if (position.y() == 0 || not tablero.objetosEn(abajo, position).isEmpty() ) //solo salta si esta en el piso o si esta arriba de una comida
          {position = position.up(7*2)}
    }

    method descender() {
        if (position.y() > 0 && tablero.objetosEn(abajo, position).isEmpty()) { //desciende si no esta en el piso y si no tiene nada abajo
            position = position.down(1)
        }
    }

    method aumentarPuntaje(cantidad) {
        puntos = puntos + cantidad
    }

    method restarVida() {
        if (vidas.any({vida => vida.estaFeliz()})) {
             vidas.find({vida => vida.estaFeliz()}).cambiarEstado()
        } 
        if (vidas.all({vida => !vida.estaFeliz()})) {
            escPrincipal.siguienteEscena(escFinal)
        }
    }

    method interactuar() {
        if(!tablero.objetosEn(arriba, position).isEmpty()){             // Si tiene un objeto en la cabeza significa que esta agarrando un tipo de comida
            tablero.objetosEn(arriba, position).first().interaccion()   // Le da prioridad a la interaccion del objeto que sostiene
        }else 
            if(!tablero.objetosEn(mirandoA, position).isEmpty()){           // Si no tiene un obj en la cabeza, se fija si existe algun obj en la direccion donde esta mirando
                tablero.objetosEn(mirandoA, position).first().interaccion() // Si dicho obj existe, entonces lo va agarrar
            }
    }

    method soltarComida() { //en la posicion donde esta molly 
        const comidaLevantada = tablero.objetosEn(arriba, position).uniqueElement() //a discutir.. no es necesario xq es lo mismo
        comidaLevantada.estaSiendoLevantada(false) //la comida deja de ser levantada
        comidaLevantada.position(position) // cambia la posicion de la comida por la posicion de molly
        position = position.up(7) // molly queda arriba de la comida
        
    }
}

object corazones {
    const property list = [vida1,vida2,vida3]
   

    const vida1 = new Corazon(position = game.at(126/2+10, 70-7), estaFeliz = true) // Corazon de la izquierda
    const vida2 = new Corazon(position = game.at(126/2, 70-7), estaFeliz = true)    // Corazon del medio
    const vida3 = new Corazon(position = game.at(126/2-10, 70-7), estaFeliz = true) // Corazon de la derecha

}