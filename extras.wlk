import wollok.game.*
import molly.*
import comidas.*

object piso {
    var property position = game.at(0, 0)
    var property image = "piso.png" 
}

object izquierda {
    method estaMirando() = molly.mirandoA() == self 
    method mollyMirando() {
        return "molly.png"
    }
}

object derecha {
    method estaMirando() = molly.mirandoA() == self 
    method mollyMirando() {
        return "molly.png"
    }
}

object celdas {
    method verificarMovimientoMolly(posicion) {
        if(variasComidas.any({comida => posicion == comida.position()})){
            self.error("no puede pasar, hay una comida ahi")
        }
    }
}