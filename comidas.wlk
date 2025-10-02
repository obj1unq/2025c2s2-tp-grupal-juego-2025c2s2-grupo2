import wollok.game.*
import molly.*


class Comida {
    var property estaSiendoLevantada = false
    var property image = null
    var property position = null
    var velocidad = 1

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(1))
        if(position.y() > 4 && objetosDebajo.isEmpty()) {
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

const variasComidas = [manzana, pasto, flor]
const manzana   = new Comida(image = "manzana.png"
                ,position = game.at(0.randomUpTo(144),  140),
                velocidad = 5)
const pasto     = new Comida(image = "pasto.png"
                , position = game.at(0.randomUpTo(144), 140),
                velocidad = 10 )
const flor      = new Comida(image = "flor.png"
                , position = game.at(0.randomUpTo(144), 140) ,
                velocidad = 4)
