import wollok.game.*
import molly.*

class Manzana {
    var property estaSiendoLevantada = false
    var property image = "manzana.png"
    var property position = game.at(self.posX(), 70)
    var property agarradaPor = null 
    var property tipo = "manzana"

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(7))
        if(position.y() > 0 && objetosDebajo.isEmpty()) {
            position = position.down(1)
        }
    }

     method posX() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }

}

class Zanahoria {
    var property estaSiendoLevantada = false
    var property image = "BIGZANAHORIA.png"
    var property position = game.at(self.posX(), 70)
    var property agarradaPor = null 
    var property tipo = "zanahoria"

    method descender() {  //Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(7))
        if(position.y() > 0 && objetosDebajo.isEmpty()) {
            position = position.down(1)
        }
    }

     method posX() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }
}

class Sandia {
    var property estaSiendoLevantada = false
    var property image = "sandia.png"
    var property position = game.at(self.posX(), 70)
    var property agarradaPor = null 
    var property tipo = "sandia"

    method descender() {  //Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(7))
        if(position.y() > 0 && objetosDebajo.isEmpty()) {
            position = position.down(1)
        }
    }

     method posX() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }
}

object spawner {
    const property instancias = []

    method instanciarManzana() {
        var manzana = new Manzana()
        game.addVisual(manzana)
        instancias.add(manzana)
    }

    method instanciarSandia() {
        var sandia = new Sandia()
        game.addVisual(sandia)
        instancias.add(sandia)
    }

    method instanciarZanahoria() {
        var zanahoria = new Zanahoria()
        game.addVisual(zanahoria)
        instancias.add(zanahoria)
    }

    method instanciarAleatorio() {
        const bloques = [{self.instanciarSandia()}, {self.instanciarZanahoria()}, {self.instanciarManzana()}]
        bloques.randomize() 
        bloques.first().apply()
        console.println(instancias.size())
    }
}
