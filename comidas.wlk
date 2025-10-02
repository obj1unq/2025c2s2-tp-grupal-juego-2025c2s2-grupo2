import wollok.game.*
import molly.*

class Comida {

    var property position = game.at(5, 5)
    var property image = null
    var property estaSiendoLevantada = false

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(1))
        if(position.y() > 0 || objetosDebajo.isEmpty() ) {
            position = position.down(1)
        }
    }

    method agarrar() {
        estaSiendoLevantada = true
        position = game.at(molly.position().x(), molly.position().y() + 2)
    }

    method puntosQueOtorga(){
        return 20
    }

}

const variasComidas = [manzana]

const manzana   = new Comida(image = "manzana.png")
