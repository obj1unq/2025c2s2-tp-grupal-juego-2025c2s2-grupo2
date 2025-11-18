import wollok.game.*
import extras.*
import comidas.*

object molly {
    var property mirandoA = der //para cambiar imagen dependiendo a donde este mirando cuando se mueve derecha o izquierda
    var property position = game.at(0, 0)
    var property vidas = []
    var property puntos = 0
    var property comidaLevantada = null
    var property lanzandoComida = false
    var property apuntar = null //direccion (es preferible usar la variable de mirandoA q ya tiene der o izq)
    
    method image() = "molly-" + mirandoA.nombreDir() + ".png"

    method vidasRestantes(){
        return vidas.filter({vida => vida.estaFeliz()}).size()
    }

    method sostenerCaja() {
        if(der.estaMirandoMolly()){ // molly esta mirando a la comida de la der
            comidaLevantada = game.getObjectsIn(position.right(7)).first() //agarra la comida en la posicion 
            comidaLevantada.estaSiendoLevantada(true)
        }
        else {  //molly esta mirando a la comida de la izq
            comidaLevantada = game.getObjectsIn(position.left(7)).first()
            comidaLevantada.estaSiendoLevantada(true)
        }

    }

    method soltarCaja() { //en la posicion donde esta molly 
        comidaLevantada = game.getObjectsIn(position.up(7)).first() //a discutir.. no es necesario xq es lo mismo
        comidaLevantada.estaSiendoLevantada(false) //la comida deja de ser levantada
        comidaLevantada.pos(position) // cambia la posicion de la comida por la posicion de molly
        position = position.up(7) // molly queda arriba de la comida
        
    }

    method lanzandoCaja() { // cambiar nombre, es el evento que desliza la caja
        if(lanzandoComida){ 
            comidaLevantada.lanzar(apuntar) //apuntar = mirandoA ?
        }
    }

    method lanzarCaja() {
        if (comidaLevantada != null) {
            lanzandoComida = true
            comidaLevantada.estaSiendoLevantada(false)
            comidaLevantada.pos(position)
            apuntar = mirandoA  // a discutir... tiene mas sentido que apuntar sea mirandoA 
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
        const objetoDir = game.getObjectsIn(direccion.siguiente(position))                 // Me da lista de objetos en la posicion a la que me quiero mover               
        if (not objetoDir.isEmpty()){ // Indica si quiere salirse del borde izquierdo, derecho, y si hay un objeto en donde me quiero mover
            self.error("hay un objeto en esa direccion")                                                                 // String vacio significa que no se mueve!
        } 
    }

    method validarSalirBordes(direccion){
        const bordeIzq = self.position().x() == 0 && izq.estaMirandoMolly()                
        const bordeDer = self.position().x() >= game.width()-10 && der.estaMirandoMolly() 
        if ((bordeIzq && direccion.nombreDir() == "izq") || (bordeDer && direccion.nombreDir() == "der")){                              
            self.error("no podes salirte del borde")                                                                 
        }
    }

    method saltar() {
        if (position.y() == 0 || not game.getObjectsIn(position.down(7)).isEmpty() ) //solo salta si esta en el piso o si esta arriba de una comida
          {position = position.up(10)}
    }

    method descender() {
       const objetosDebajo = game.getObjectsIn(position.down(7))
        if (position.y() > 0 && objetosDebajo.isEmpty()) { //desciende si no esta en el piso y si no tiene nada abajo
            position = position.down(1)
        }
    }

    method aumentarPuntaje(cantidad) {
        puntos = puntos + cantidad
    }
}