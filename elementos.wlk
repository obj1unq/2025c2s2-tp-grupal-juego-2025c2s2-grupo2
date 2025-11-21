import tablero.*
import wollok.mirror.*
import wollok.game.*
import molly.*
import extras.*

class Comida inherits Elementos{
    var property agarradaPor = null
    var property estaSiendoLevantada = false

    method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return pos}
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

    method explotar() {
        spawner.borrarInstancia(self)
        var acumulador = self.puntos()
        const lindantes = tablero.lindantes(self) //delegamos al tablero
        if(not lindantes.isEmpty()){
            lindantes.forEach({comidas => comidas.explotar()
            acumulador += comidas.puntos()})
        }
        molly.aumentarPuntaje(acumulador)
    }
}

object manzana inherits TipoDeElemento {
    override method image() = "manzana.png"
    override method puntos() = 10
}

object zanahoria inherits TipoDeElemento {
    override method image() = "BIGZANAHORIA.png" 
    override method puntos() = 20
}

object sandia inherits TipoDeElemento{
    override method image() = "sandia.png"
    override method puntos() = 30
}

object pincho inherits TipoDeElemento{
    override method image() = "pincho.png"
    override method puntos() = 0
    override method instanciar() = new Pincho(tipo = self)
}

class TipoDeElemento {
    method image()
    method puntos()

    method instanciar() = new Comida(tipo = self)
}

class Pincho inherits Elementos{ 
    method position() = pos 

    override method descender() {
        const objetosDebajo = game.getObjectsIn(pos.down(7))
        if (objetosDebajo.contains(molly)){ 
            molly.restarVida() 
            self.destruir()         
            }
        if (pos.y() == 0) { 
            self.destruir()
        }
        if (pos.y() > 0 && objetosDebajo.isEmpty()){
            pos = pos.down(1) }
    }

    method destruir() {
        spawner.borrarInstancia(self)
    }

}

class Elementos {
    var property pos = game.at(self.posX(), 56)
    const property tipo

    method image() = tipo.image() //se sobreescribe en las comidas
    method puntos() = tipo.puntos()
    
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

    method posX() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }

}

object spawner {
    const property instancias = []
    const tipos = [manzana, sandia, zanahoria, pincho]

    method instaciarComida(tipo) {
        const elemento = tipo.instanciar()
        game.addVisual(elemento)
        instancias.add(elemento)    
    }

    method instanciarAleatorio() {
        self.instaciarComida(tipos.anyOne())
    }

    method borrarInstancia(instancia) {
        instancias.remove(instancia)
        game.removeVisual(instancia)
    }
}