import wollok.game.*
import molly.*


class Comida {
    var property estaSiendoLevantada = false
    var property image = null
    var property position = null
    var velocidad = 1

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(1))
        if(position.y() > 0 || objetosDebajo.isEmpty()) {
            position = position.down(velocidad)
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
