import tablero.*
import wollok.game.*
import molly.*
import extras.*

class Elementos {
    const property tipo  // Referencia de la instancia de la clase

    var property position = game.at(self.posicionAleatoria(), 56)
    var property image = tipo.image() //se sobreescribe en las comidas
    method puntos() = tipo.puntos()
    
    method descender() {  
        if(position.y() > 0 && tablero.objetosEn(abajo, position).isEmpty()) {
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

    method destruir() { // Destruye el elemento con un efecto de explosion
        const explosion = new Explosion(position = position) // Nueva explosion en la posicion del elemento a destruir
        spawner.borrarInstancia(self)  // Se borra la instancia del elemento que se destruye
        explosion.spawnear()           // Aparece y desaparece la explosion
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

class Explosion {  // Clase explosion porque habrán varias explosiones
    var property position
    method image() = "explosion.png"
    method spawnear(){
        game.addVisual(self)      // Agrega el visual de la explosion
        game.schedule(500, {game.removeVisual(self)})  // Desaparece la explosion despues de 5 segundos
    }
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
        if (tablero.objetosEn(abajo, position).contains(molly)){  // Si tiene a Molly debajo...
            molly.restarVida()        // Le saca una vida a Molly
            self.destruir()           // Se destruye
        }
        if (position.y() > 0 && tablero.objetosEn(abajo, position).isEmpty()){ // Si esta en el aire y no tiene nada abajo, desciende
            position = position.down(1) 
        }
        else{
            self.destruir() // Si tiene algo abajo (no esta en el piso), que no es molly, solo se destruye
        }
    }
}

class Bomba inherits Dañino{
    override method destruir(){ // Destruir de Elementos
        const cosaLindante = tablero.cosasEnLindantesDe(self)
        if(not cosaLindante.contains(molly)){ // Si no está Molly en las lindantes...
            cosaLindante.forEach({cosa => cosa.destruir()})  // Destruir lo que este en las lindantes
        }
        else if(tablero.objetosEn(abajo, position).contains(molly)){  // Si está Molly debajo de la bomba, solo destruye lo que tiene al rededor ...
            cosaLindante.copyWithout(molly).forEach({cosa => cosa.destruir()}) // sin destruir a molly ni restarle vida, ya que Descender ya le resta una vida
        }
        else {  // Si está Molly en alguna lindante...
            cosaLindante.copyWithout(molly).forEach({cosa => cosa.destruir()})  // Destruye lo que esté en las lindantes sin destruir a Molly
            molly.restarVida()  // Le resta una vida a Molly
        }
        super()  // Explota la bomba
    }
}


object spawner {
    const property instancias = []
    const tiposDeComida = [manzana, sandia, zanahoria]
    const tiposDeDañino = [pincho]

    method instaciarComidaAleatoria() {
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
    
    method instanciarAlgunDañino(){
        const bloque = [{self.instanciarDañinoAleatorio()},
                        {self.instanciarBomba()}]
        const instancia = bloque.anyOne()
        instancia.apply()
    }

    method borrarInstancia(instancia) {
        instancias.remove(instancia)
        game.removeVisual(instancia)
    }
}