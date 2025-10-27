import wollok.mirror.*
import wollok.game.*
import molly.*
import extras.*

class Manzana {
    var property estaSiendoLevantada = false
    var property image = "manzana.png"
    var property pos = game.at(self.posX(), 70)
    var property agarradaPor = null 
    var property tipo = "manzana"

    method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return pos}
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

    method mover(unaDireccion){
        if (unaDireccion.nombreDir() == "der"){
            pos = pos.right(1)
        }
        else{
            pos = pos.left(1)
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

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(pos.down(7))
        if(pos.y() > 0 && objetosDebajo.isEmpty()) {
            pos = pos.down(1)
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
        const lindantes = self.lindantes()
        if(not lindantes.isEmpty()){
            lindantes.forEach({comidas => comidas.explotar()})
        }
    }

}

class Zanahoria {
    var property estaSiendoLevantada = false
    var property image = "BIGZANAHORIA.png"
    var property pos = game.at(self.posX(), 70)
    var property agarradaPor = null 
    var property tipo = "zanahoria"

    method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return pos}
    }

    method descender() {  //Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(pos.down(7))
        if(pos.y() > 0 && objetosDebajo.isEmpty()) {
            pos = pos.down(1)
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
        const lindantes = self.lindantes()
        if(not lindantes.isEmpty()){
            lindantes.forEach({comidas => comidas.explotar()})
        }
    }
}

class Sandia {
    var property estaSiendoLevantada = false
    var property image = "sandia.png"
    var property pos = game.at(self.posX(), 70)
    var property agarradaPor = null 
    var property tipo = "sandia"

    method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return pos}
    }

    method descender() {  //Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(pos.down(7))
        if(pos.y() > 0 && objetosDebajo.isEmpty()) {
            pos = pos.down(1)
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
        const lindantes = self.lindantes()
        if(not lindantes.isEmpty()){
            lindantes.forEach({comidas => comidas.explotar()})
        }
    }
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
