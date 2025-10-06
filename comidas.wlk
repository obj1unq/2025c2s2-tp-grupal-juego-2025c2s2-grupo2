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


const variasComidas = []
object spawner {

    //const ubicacionesPermitidas = [0,7,14,21,28,35,42,49,56,63,70,77,84,91,98,105,112,119,126]
    const listaDeBloques = [
    {var manzana = new Manzana()}, 
    {var zanahoria = new Zanahoria()}, 
    {var sandia = new Sandia()}
    ]

    method instanciar() {
        variasComidas.add(
            listaDeBloques.randomize().apply()
        )
        console.println( "Cantidad de Objetos = " + variasComidas.size())
    }

}
