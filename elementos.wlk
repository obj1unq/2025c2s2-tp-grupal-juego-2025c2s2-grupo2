import tablero.*
import wollok.mirror.*
import wollok.game.*
import molly.*
import extras.*

class Comida {
    var property pos = game.at(self.posX(), 56)
    var property agarradaPor = null
    var property estaSiendoLevantada = false
    const property tipo

    method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return pos}
    }

    method image() = tipo.image() //se sobreescribe en las comidas

    method puntos() = tipo.puntos()//se sobreescribe en las comidas

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

object manzana inherits TipoDeComida {
    override method image() = "manzana.png"

    override method puntos() = 10
}

object zanahoria inherits TipoDeComida {
    override method image() = "BIGZANAHORIA.png" 

    override method puntos() = 20
}

object sandia inherits TipoDeComida{
    override method image() = "sandia.png"

    override method puntos() = 30
}

class TipoDeComida {
    method image()
    method puntos()
}

class Pincho {
    var pos
    method position() = pos 
    method image() = "pinchos.png"

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
}

object spawner {
    const property instancias = []
    const tipos = [manzana, sandia, zanahoria]

    method instaciarComida(tipoComida) {
        const _comida = new Comida(tipo = tipoComida)
        game.addVisual(_comida)
        instancias.add(_comida)    
    }

    method instanciarAleatorio() {
        self.instaciarComida(tipos.anyOne())
    }
}