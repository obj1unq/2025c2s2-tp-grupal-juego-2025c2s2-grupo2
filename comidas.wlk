import wollok.mirror.*
import wollok.game.*
import molly.*
import extras.*

class Comida {
    var property pos = game.at(self.posX(), 70)
    var property agarradaPor = null
    var property estaSiendoLevantada = false

    method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return pos}
    }

    method image()

    method puntos()

    method descender() {  //Usar OnTick, va a caer gradualmente
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
        if (self.lindantesEn(unaDireccion).isEmpty()){
            self.validarMoverse(unaDireccion)
            self.mover(unaDireccion)
        } else {
            self.lindantesEn(unaDireccion).first().explotar()
            molly.lanzandoComida(false)
            molly.comidaLevantada(null)
        }
    }

    method validarMoverse(direccion) {
        const bordeIzq = self.position().x() == 0                
        const bordeDer = self.position().x() >= game.width()-10 
        const objetoDir = game.getObjectsIn(direccion.siguiente(self.position()))                 
        if (bordeIzq || bordeDer || not objetoDir.isEmpty()){                              
            self.error("")                                                                 
        } 
    }

    method posX() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }

    method lindantesEn(unaDireccion) {
        const filtrado = game.getObjectsIn(unaDireccion.siguiente(pos))
        if(filtrado.any({obj => obj.kindName() != self.kindName()})){
            filtrado.remove(filtrado.find({obj => obj.kindName() != self.kindName()}))
        }
        return filtrado
    }

    method lindantes() {
        const dir = [arriba,abajo,der,izq]
        const acumulador = []
        dir.forEach({aDir => self.agregarSiExiste(acumulador, aDir)})
        return acumulador
    }

    method agregarSiExiste(unaLista, unaDireccion) { 
        const acumulador = []
        if(not self.lindantesEn(unaDireccion).isEmpty()){
            unaLista.add(self.lindantesEn(unaDireccion).first())
        }
    }

    method explotar() {
        game.removeVisual(self)
        var acumulador = self.puntos()
        const lindantes = self.lindantes()
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
