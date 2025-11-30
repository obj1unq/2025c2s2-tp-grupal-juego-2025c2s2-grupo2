import wollok.game.*
import extras.*
import elementos.*
import escenas.*
import tablero.*

object molly {
    var property mirandoA = der //para cambiar imagen dependiendo a donde este mirando cuando se mueve derecha o izquierda
    var property position = game.at(0, 0)
    var property vidas = [vida1, vida2, vida3]
    var property puntos = 0
    var property comidaLevantada = null
    var property lanzandoComida = false
    var property apuntandoA = null //direccion a la que apunta cuando se esta lanzando
    const vida1 = new Corazon(position = game.at(126/2+10, 70-7), estaFeliz = true) // Corazon de la izquierda
    const vida2 = new Corazon(position = game.at(126/2, 70-7), estaFeliz = true)    // Corazon del medio
    const vida3 = new Corazon(position = game.at(126/2-10, 70-7), estaFeliz = true) // Corazon de la derecha

    method image() = "molly-" + mirandoA.nombreDir() + ".png"

    method vidasRestantes(){
        return vidas.filter({vida => vida.estaFeliz()}).size()
    }

    method sostenerCaja() {
        if(der.estaMirandoMolly()){ // molly esta mirando a la comida de la der
            comidaLevantada = tablero.objetosEn(der, position).uniqueElement() //agarra la comida en la posicion 
            comidaLevantada.estaSiendoLevantada(true)
        }
        else {  //molly esta mirando a la comida de la izq
            comidaLevantada = tablero.objetosEn(izq, position).uniqueElement()
            comidaLevantada.estaSiendoLevantada(true)
        }

    }

    method soltarCaja() { //en la posicion donde esta molly 
        comidaLevantada = tablero.objetosEn(arriba, position).uniqueElement() //a discutir.. no es necesario xq es lo mismo
        comidaLevantada.estaSiendoLevantada(false) //la comida deja de ser levantada
        comidaLevantada.position(position) // cambia la posicion de la comida por la posicion de molly
        position = position.up(7) // molly queda arriba de la comida
        
    }

    method lanzandoCaja() { // cambiar nombre, es el evento que desliza la caja
        if(lanzandoComida){ 
            comidaLevantada.lanzar(apuntandoA) //apuntandoA = mirandoA ?
        }
    }

    method lanzarCaja() {
        if (comidaLevantada != null) {
            lanzandoComida = true
            comidaLevantada.estaSiendoLevantada(false)
            comidaLevantada.position(position)
            apuntandoA = mirandoA  // a discutir... tiene mas sentido que apuntandoA sea mirandoA 
            self.lanzandoCaja()
        }
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
}