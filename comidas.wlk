import wollok.game.*
import molly.*
import extras.*

class Comida {
    var property estaSiendoLevantada = false
    var property image = null
    var property position = null
    var property velocidad = null
    var property agarradaPor = null 
    var property enMovimiento = false
    var property direccion = null

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(1))
        if(position.y() > 0 && objetosDebajo.isEmpty()) {
            position = game.at(position.x(), position.y() - 1)
        }
    }

    method agarrar(jugador) {
        self.estaSiendoLevantada(true)
        self.agarradaPor(jugador)
        // posicion inicial, justo encima
        self.position(game.at(jugador.position().x(), jugador.position().y() + 5))
    }

    method puntosQueOtorga(){
        return 20
    }

    method lanzar(unaDireccion) {
        self.estaSiendoLevantada(false)
        self.agarradaPor(null)
        self.direccion(direccion)
        self.enMovimiento(true)
        self.mover()
    }

    method moverHacia(direccion){
        if (direccion == "der") {
            self.position(game.at(self.position().x() + velocidad, self.position().y()))
        } else {
            self.position(game.at(self.position().x() - velocidad, self.position().y()))
        }
    }

    method mover() {
        if (celdas.puedeMoverCaja(self, direccion) && enMovimiento){
            self.moverHacia(direccion)
        } else {
            enMovimiento = false
        }
    }   
}

const variasComidas = []

object spawner {
    method instanciar() {
        const elemento = new Comida(image = "sandia.png"
                ,position = game.at(50, 50),
                velocidad = 1)
        variasComidas.add(elemento)
        console.println(variasComidas.size())
    }

    method posXRandom() {
        return 0.randomUpTo(144)
    }

}
