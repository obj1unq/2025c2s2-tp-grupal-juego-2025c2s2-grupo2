import wollok.game.*

object bomba {
    var property position = game.at(0.randomUpTo(game.height()), game.width())
    var property image = "bombita.png"

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(1))
        if(position.y() > 0 || objetosDebajo.isEmpty() ) {
            position = position.down(1)
        }
    }

    method puntosQueOtorga(comida){
        return 10 * comida.puntosQueOtorga()
    }
}