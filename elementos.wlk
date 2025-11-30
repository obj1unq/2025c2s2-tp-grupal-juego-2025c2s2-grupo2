import tablero.*
import wollok.mirror.*
import wollok.game.*
import molly.*
import extras.*

class Elementos {
    //var property pos = game.at(self.posicionAleatoria(), 56)
    const property tipo  // Referencia de la instancia de la clase

    var property position = game.at(self.posicionAleatoria(), 56)
    var property image = tipo.image() //se sobreescribe en las comidas
    method puntos() = tipo.puntos()
    
    method descender() {  
        const objetosDebajo = game.getObjectsIn(position.down(7)) // Cambiar a objetoLidante tablero!!! Arreglar porfa!!!! 
        if(position.y() > 0 && objetosDebajo.isEmpty()) {
            position = position.down(1)
        }
    }

    method mover(unaDireccion){
        if (unaDireccion.nombreDir() == "der"){
            position = position.right(1)
        }
        else{
            position = position.left(1)
        }
    }

    method posicionAleatoria() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }

    method destruir() { 
        image = "exploision.png"
        game.schedule(500, {spawner.borrarInstancia(self)})
        console.println(self)
    }
}

class TipoDeElemento {  
    method image()
    method puntos()
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
}

object bomba inherits TipoDeElemento{
    override method image() = "bomba.png"
    override method puntos() = 0
}

class Comida inherits Elementos{
    var property agarradaPor = null
    var property estaSiendoLevantada = false

    override method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return position}
    }

    method lanzar(unaDireccion) {
        if (tablero.lindantesDelMismoTipo(self, unaDireccion).isEmpty()){ //delegamos al tablero 
            tablero.validarMoverse(self, unaDireccion) //delegamos al tablero
            self.mover(unaDireccion)
        } else {
            tablero.lindantesDelMismoTipo(self, unaDireccion).first().explotar() //delegamos al tablero
            molly.lanzandoComida(false)
            molly.comidaLevantada(null)
        }
    }

    method explotar() {
        spawner.borrarInstancia(self)
        var acumulador = self.puntos()
        const cosaLindante = tablero.cosaLindante(self) //delegamos al tablero
        if(not cosaLindante.isEmpty()){
            cosaLindante.forEach({comidas => comidas.explotar()
            acumulador += comidas.puntos()})
        }
        molly.aumentarPuntaje(acumulador)
    }
}

class Dañino inherits Elementos{ 
    override method descender() {
        const objetosDebajo = game.getObjectsIn(position.down(7))
        if (objetosDebajo.contains(molly)){  // Si tiene a Molly debajo, le saca una vida a Molly y se destruye
            self.destruir()         
            //molly.restarVida() 
            }
        if (position.y() == 0) { // Si llega al piso, explota
             self.destruir()
            }
        if (position.y() > 0 && objetosDebajo.isEmpty()){ // Si esta en el aire y no tiene nada abajo, desciende
            position = position.down(1) }
    }
}

class Bomba inherits Dañino{
    override method destruir(){ 
        const cosaLindante = tablero.cosasEnLindantesDe(self)
        if(not tablero.cosasEnLindantesDe(self).contains(molly)){
            cosaLindante.forEach({cosa => cosa.destruir()})
        }
        else {
            molly.restarVida()
        }
        super()
    }
}


object spawner {
    const property instancias = []
    const tiposDeComida = [manzana, sandia, zanahoria]
    const tiposDeDañino = [pincho]

    method instaciarComidaAleatoria() {
        // const elemento = tipo.instanciar()
        // game.addVisual(elemento)
        // instancias.add(elemento) 

        const unaComida = new Comida(tipo = tiposDeComida.anyOne())
        game.addVisual(unaComida)
        instancias.add(unaComida)   
    }

    method instanciarDañinoAleatorio(){
        const unDañino = new Dañino (tipo = tiposDeDañino.anyOne())
        game.addVisual(unDañino)
        instancias.add(unDañino) 
    }

    method instanciarBomba(){
        const unaBomba = new Bomba (tipo = bomba)
        game.addVisual(unaBomba)
        instancias.add(unaBomba)
    }

    method instanciarAlguno() {
        const bloque = [{self.instaciarComidaAleatoria()},
                        {self.instanciarDañinoAleatorio()},
                        {self.instanciarBomba()}]
        const instancia = bloque.anyOne()
        instancia.apply()
    }

    method borrarInstancia(instancia) {
        instancias.remove(instancia)
        game.removeVisual(instancia)
    }
}