import wollok.game.*
import molly.*
import comidas.*

object piso {
    var property position = game.at(0, 0)
    var property image = "piso.png" 
}

object izq {
    method nombreDir() {
        return "izq"
    }
    method siguiente(position){
        return position.left(7)
    }
    method estaMirandoMolly(){
        return molly.mirandoA() == self
    }
}

object der {
    method nombreDir() {
        return "der"
    }
    method siguiente(position){
        return position.right(7)
    }
    method estaMirandoMolly(){
        return molly.mirandoA() == self
    }
}

class Hitbox {
    var property x1 = 0
    var property y1 = 0
    var property x2 = 0
    var property y2 = 0

    method colisionaCon(otraHitbox) {
        return self.x1() < otraHitbox.x2() and
               self.x2() > otraHitbox.x1() and
               self.y1() < otraHitbox.y2() and
               self.y2() > otraHitbox.y1()
    }
}

object celdas {
    method verificarMovimientoMolly(nuevaPosicion, direccion) {
        const offset = if (direccion == "derecha") 10 else 0

        // Definir la hitbox de Molly en la nueva posición
        const mollyBox = new Hitbox(
            x1 = nuevaPosicion.x() + offset, 
            y1 = nuevaPosicion.y(), 
            x2 = nuevaPosicion.x() + 10 + offset,
            y2 = nuevaPosicion.y() + 10
        )

        // Verificar si hay colisiones con alguna comida
        if (variasComidas.any({comida =>
            const comidaBox = new Hitbox(x1 = comida.position().x(),
            y1 = comida.position().y(),
            x2 = comida.position().x() + 10,
            y2 = comida.position().y() + 10)
            mollyBox.colisionaCon(comidaBox)
        })) {
            self.error("error")  // Hay colisión, no se puede mover
        }
    }

    method puedeMoverCaja(caja, direccion) {
        const nuevaX = if (direccion == "der") caja.position().x() + caja.velocidad() else caja.position().x() - caja.velocidad()
        const nuevaPos = game.at(nuevaX, caja.position().y())

        // Chequea si toca bordes
        if (nuevaX <= 0 or nuevaX >= game.width() - 10) return false

        // Chequea colisión con otras comidas
        return not (variasComidas.any({ otra =>
            if (otra != caja) {
                const cajaBox = new Hitbox(
                    x1 = nuevaPos.x(),
                    y1 = nuevaPos.y(),
                    x2 = nuevaPos.x() + 10,
                    y2 = nuevaPos.y() + 10
                )
                const otraBox = new Hitbox(
                    x1 = otra.position().x(),
                    y1 = otra.position().y(),
                    x2 = otra.position().x() + 10,
                    y2 = otra.position().y() + 10
                )
                cajaBox.colisionaCon(otraBox)
            } else false
        }))
    }
}


