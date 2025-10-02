import wollok.game.*
import molly.*


class Comida {

    var property image = null
    var property position = null
    var velocidad = 1

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(1))
        if(position.y() > 0 || objetosDebajo.isEmpty()) {
            position = position.down(velocidad)
        }
    }

    method puntosQueOtorga(){
        return 20
    }
   
}
