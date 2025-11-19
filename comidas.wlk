import tablero.*
import wollok.mirror.*
import wollok.game.*
import molly.*
import extras.*

class Comida {
    var property pos = game.at(self.posX(), 56)
    var property agarradaPor = null
    var property estaSiendoLevantada = false

    method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return pos}
    }

    method image() //se sobreescribe en las comidas

    method puntos() //se sobreescribe en las comidas

    method descender() {  
        const objetosDebajo = game.getObjectsIn(pos.down(7))
        if(pos.y() > 0 && objetosDebajo.isEmpty()) {
            pos = pos.down(1)
        }
    }

    method mover(unaDireccion){
        if (unaDireccion.nombreDir() == "der"){
            pos = pos.right(1)
        }
        else{
            pos = pos.left(1)
        }
    }

    method lanzar(unaDireccion) {
        if (tablero.lindantesEn(self, unaDireccion).isEmpty()){ //delegamos al tablero 
            tablero.validarMoverse(self, unaDireccion) //delegamos al tablero
            self.mover(unaDireccion)
        } else {
            tablero.lindantesEn(self, unaDireccion).first().explotar() //delegamos al tablero
            molly.lanzandoComida(false)
            molly.comidaLevantada(null)
        }
    }

    method posX() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }

    method explotar() {
        game.removeVisual(self)
        var acumulador = self.puntos()
        const lindantes = tablero.lindantes(self) //delegamos al tablero
        if(not lindantes.isEmpty()){
            lindantes.forEach({comidas => comidas.explotar()
            acumulador += comidas.puntos()})
        }
        molly.aumentarPuntaje(acumulador)
    }
}

class Manzana inherits Comida {
    override method image() = "manzana.png"

    override method puntos() = 10
}

class Zanahoria inherits Comida {
    override method image() = "BIGZANAHORIA.png" 

    override method puntos() = 20
}

class Sandia inherits Comida{
    override method image() = "sandia.png"

    override method puntos() = 30
}

class TipoDeComida {
method image()
method puntos()
}

object spawner {
    const property instancias = []

    method instanciarManzana() {
        const manzana = new Manzana()
        game.addVisual(manzana)
        instancias.add(manzana)
    }

    method instanciarSandia() {
        const sandia = new Sandia()
        game.addVisual(sandia)
        instancias.add(sandia)
    }

    method instanciarZanahoria() {
        const zanahoria = new Zanahoria()
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
