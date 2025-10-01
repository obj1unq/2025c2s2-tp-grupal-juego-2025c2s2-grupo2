import wollok.game.*

object molly {
    var property image = "molly.png"
    var property position = game.at(0, 1)
    var property vidas = 3
    var property puntos = 0
    var property pasoPrevio = position 
    var property mirandoA = ""
    
    method sostenerCaja(unaComida){
        if(position == unaComida){
            unaComida.estaSiendoSostenida()
        }
    }

    method moverseDerecha() {
        self.validarMoverseDerecha()
        pasoPrevio = position
		position = game.at(self.position().x() + 1, self.position().y())
	}

	method moverseIzquierda() {
		self.validarMoverseIzquierda()
        pasoPrevio = position
        position = game.at(self.position().x() - 1, self.position().y())
	}

    method volver() {
        position = pasoPrevio
    }

    method validarMoverseDerecha() {
        if (self.position().x() == game.height() - 1){
            self.error("esta en un borde por ende no se puede mover")
        }
    }

    method validarMoverseIzquierda() {
        if (self.position().x() == 0){
            self.error("esta en un borde por ende no se puede mover")
        }
    }

    method saltar() {
        position = game.at(position.x(), position.y() + 1)
    }

    method descender() {
        if(position.y() > 1){
            position = game.at(position.x(), position.y() - 1)  
        }
    }
}