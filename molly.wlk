import wollok.game.*
import extras.*


object molly {
    var property image = mirandoA.mollyMirando()
    var property position = game.at(0, 5)
    var property vidas = 3
    var property puntos = 0
    var property mirandoA = derecha
    
    method sostenerCaja(){
        if(derecha.estaMirando()){
            game.getObjectsIn(game.at(self.position().x() + 1, self.position().y())).first().agarrar()
        }
    }

    method moverseDerecha() {
        mirandoA = derecha
        self.validarMoverseDerecha()
        celdas.verificarMovimientoMolly(game.at(self.position().x() + 1, self.position().y()))
		position = game.at(self.position().x() + 1, self.position().y())
	}

	method moverseIzquierda() {
        mirandoA = izquierda
		self.validarMoverseIzquierda()
        celdas.verificarMovimientoMolly(game.at(self.position().x() - 1, self.position().y()))
        position = game.at(self.position().x() - 1, self.position().y())
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
        position = game.at(position.x(), position.y() + 5)
    }

    method descender() {
        if(position.y() > 5){
            position = game.at(position.x(), position.y() - 1)  
        }
    }
}