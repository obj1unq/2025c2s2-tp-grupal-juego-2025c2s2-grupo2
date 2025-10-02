import wollok.game.*
import molly.*

class Comida {

    var property position = game.at(0.randomUpTo(game.height()), game.width())
    var property image = null

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

const variasComidas = [manzana,pasto,flor]

const manzana   = new Comida(image = "manzana.png")
const pasto     = new Comida(image = "pasto.png")
const flor      = new Comida(image = "flor.png")