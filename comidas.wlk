import wollok.game.*
import molly.*

object manzana {
    var property position = game.at(0.randomUpTo(game.height()), game.width())
    var property image = "manzana.png"

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(1))
        if(position.y() > 0 || objetosDebajo.isEmpty() ) {
            position = position.down(1)
        }
    }

    method puntosQueOtorga(){
        return 20
    }

}