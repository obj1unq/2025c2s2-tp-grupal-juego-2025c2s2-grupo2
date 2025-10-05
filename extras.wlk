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
        return "normal"
    }
}

object derecha {
    method estaMirando() = molly.mirandoA() == self 
    method mollyMirando() {
        return "invertida"
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
        const offset = if (direccion == "derecha") 5 else 0

        // Definir la hitbox de Molly en la nueva posición
        const mollyBox = new Hitbox(
            x1 = nuevaPosicion.x() + offset, 
            y1 = nuevaPosicion.y(), 
            x2 = nuevaPosicion.x() + 5 + offset,
            y2 = nuevaPosicion.y() + 5
        )

        // Verificar si hay colisiones con alguna comida
        if (variasComidas.any({comida =>
            const comidaBox = new Hitbox(x1 = comida.position().x(),
            y1 = comida.position().y(),
            x2 = comida.position().x() + 5,
            y2 = comida.position().y() + 5)
            mollyBox.colisionaCon(comidaBox)
        })) {
            self.error("error")  // Hay colisión, no se puede mover
        }
    }
}

object puntaje {
   var property position = game.at(4, 68)
   method text () = "PUNTOS:" + " " + self.calcularPuntaje()

   method calcularPuntaje() {
        return 10
   } 
    
}

object vidas {
    var property position =  game.at((126 / 2), 68)
    method text() = "VIDAS:" + " " + self.vidasRestantes()

    method vidasRestantes() {
        return 3
      
    }
}

object tiempo {
    var property position = game.at (123, 68)
    method text () = "03:00" 
}


