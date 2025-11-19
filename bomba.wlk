import wollok.game.*
import comidas.*
object bomba {
    var property position = game.at(0.randomUpTo(144), 140)
    var property image = "bombita.png"

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(1))
        if(position.y() > 0 || objetosDebajo.isEmpty() ) {
            position = position.down(1)
        }
    }

    /*method explotar(){
        self.validarSiExplota()
        image = "explosion.png"

        
        game.removeVisual(self)
    }

    method validarSiExplota(){

    }*/ //hay que verlo...
}
