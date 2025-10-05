import wollok.game.*
import molly.*


class Comida {
    var property estaSiendoLevantada = false
    var property image = null
    var property position = null
    var property velocidad = null
    var property agarradaPor = null 

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

    //-----------------------------------------------------------------------

    method instanciarComida(){
        const elemento = new Comida(image = "manzana.png"
                ,position = game.at((0.randomUpTo(144) / 5).round() * 5, 50),
                velocidad = 1)
        variasComidas.add(elemento)
        console.println(variasComidas.size())
    }

}

const variasComidas = []

const manzana   = new Comida(image = "manzana.png"
                ,position = game.at((0.randomUpTo(144) / 5).round() * 5, 120),
                velocidad = 1)
/*
const zanahoria     = new Comida(image = "BIGZANAHORIA.png"
                , position = game.at((0.randomUpTo(144) / 5).round() * 5, 120),
                velocidad = 1 )
const sandia      = new Comida(image = "sandia.png"
                , position = game.at((0.randomUpTo(144) / 5).round() * 5, 120) ,
                velocidad = 1)
*/
