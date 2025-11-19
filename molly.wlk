import wollok.game.*
import extras.*
import comidas.*

object molly {
    var property mirandoA = der
    var property position = game.at(0, 0)
    var property vidas = [vida1,vida2,vida3]
    var property puntos = 0
    var property comidaLevantada = null
    var property lanzandoComida = false
    var property apuntar = null
    
    method image() = "molly-" + mirandoA.nombreDir() + ".png"

    method vidasRestantes(){
        return vidas.filter({vida => vida.estaFeliz()}).size()
    }

    method sostenerCaja() {
        if(der.estaMirandoMolly()){
            comidaLevantada = game.getObjectsIn(position.right(7)).first()
            comidaLevantada.estaSiendoLevantada(true)
        }
        else {  
            comidaLevantada = game.getObjectsIn(position.left(7)).first()
            comidaLevantada.estaSiendoLevantada(true)
        }

    }

    method soltarCaja() {
        comidaLevantada = game.getObjectsIn(position.up(7)).first()
        comidaLevantada.estaSiendoLevantada(false)
        comidaLevantada.pos(position)
        position = position.up(7)
        
    }

    method lanzandoCaja() {
        if(lanzandoComida){
            comidaLevantada.lanzar(apuntar)
        }
    }

    method lanzarCaja() {
        if (comidaLevantada != null) {
            lanzandoComida = true
            comidaLevantada.estaSiendoLevantada(false)
            comidaLevantada.pos(position)
            apuntar = mirandoA
            self.lanzandoCaja()
        }
    }

    method moverse(direccion) {
        mirandoA = direccion // Cambia el sprite de molly hacia la direccion donde se mueve
        self.validarMoverse(direccion)
        position = direccion.siguiente(position)
    }


    method validarMoverse(direccion) {
        const bordeIzq = self.position().x() == 0 && izq.estaMirandoMolly()                // Indica si la posicion de Molly es la del borde izquierdo y si Molly está mirando para ese borde (es decir, tiene intencion de irse al otro borde)
        const bordeDer = self.position().x() >= game.width()-10 && der.estaMirandoMolly()  // Lo mismo que arriba. Que sea mayor o igual al game width-10 significa el borde derecho (el 10 por el tamaño de celda)
        const objetoDir = game.getObjectsIn(direccion.siguiente(position))                 // Me da lista de objetos en la posicion a la que me quiero mover               
        if (bordeIzq || bordeDer || not objetoDir.isEmpty()){                              // Indica si quiere salirse del borde izquierdo, derecho, y si hay un objeto en donde me quiero mover
            self.error("")                                                                 // String vacio significa que no se mueve!
        } 
    }

    method saltar() {
        if (position.y() == 0 || not game.getObjectsIn(position.down(7)).isEmpty() )
          {position = position.up(10)}
    }

    method descender() {
       const objetosDebajo = game.getObjectsIn(position.down(7))
        if (position.y() > 0 && objetosDebajo.isEmpty()) {
            position = position.down(1)
        }
    }

    method aumentarPuntaje(cantidad) {
        puntos = puntos + cantidad
    }

    method recibirDaño() {
        self.validarRecibirDaño()
        const vidaActual = vidas.find({cor => cor.estaFeliz()})
        vidaActual.cambiarEstado()
        console.println(vidas.size())
    }

    method validarRecibirDaño() {
        if(vidas.isEmpty()){
            self.error("No existen vidas")
        }
        if(vidas.all({cor => !cor.estaFeliz()})){
            self.error("No quedan vidas que perder")
        }
    }

    const vida1 = new Corazon(position = game.at(126/2+10, 70-7), estaFeliz = true) // Corazon de la izquierda
    const vida2 = new Corazon(position = game.at(126/2, 70-7), estaFeliz = true)    // Corazon del medio
    const vida3 = new Corazon(position = game.at(126/2-10, 70-7), estaFeliz = true) // Corazon de la derecha

}