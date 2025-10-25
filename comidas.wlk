import wollok.mirror.*
import wollok.game.*
import molly.*
import extras.*

class ObjetoDePrueba {
    var property estaSiendoLevantada = false
    var property image = "zanahoria.png"
    var property pos = game.center()

    method position() {
        if (estaSiendoLevantada)
            {return game.at(molly.position().x(), molly.position().y() + 7)}
        else {return pos}
    }
    
    method posX() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(pos.down(7))
        if(pos.y() > 0 && objetosDebajo.isEmpty()) {
            pos = pos.down(1)
        }
    }

    method lindantesEn(unaDireccion) {
        var filtrado = game.getObjectsIn(unaDireccion.siguiente(pos))
        if(filtrado.any({obj => obj.kindName() != self.kindName()})){
            filtrado.remove(filtrado.find({obj => obj.kindName() != self.kindName()}))
        }
        return filtrado
    }

    method lindantes() {
        const dir = [arriba,abajo,der,izq]
        var acumulador = []
        dir.forEach({aDir => self.agregarSiExiste(acumulador, aDir)})
        return acumulador
    }

    method agregarSiExiste(unaLista, unaDireccion) { 
        var acumulador = []
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
        var filtrado = game.getObjectsIn(unaDireccion.siguiente(pos))
        if(filtrado.any({obj => obj.kindName() != self.kindName()})){
            filtrado.remove(filtrado.find({obj => obj.kindName() != self.kindName()}))
        }
        return filtrado
    }

    method lindantes() {
        const dir = [arriba,abajo,der,izq]
        var acumulador = []
        dir.forEach({aDir => self.agregarSiExiste(acumulador, aDir)})
        return acumulador
    }

    method agregarSiExiste(unaLista, unaDireccion) { 
        var acumulador = []
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
        var filtrado = game.getObjectsIn(unaDireccion.siguiente(pos))
        if(filtrado.any({obj => obj.kindName() != self.kindName()})){
            filtrado.remove(filtrado.find({obj => obj.kindName() != self.kindName()}))
        }
        return filtrado
    }

    method lindantes() {
        const dir = [arriba,abajo,der,izq]
        var acumulador = []
        dir.forEach({aDir => self.agregarSiExiste(acumulador, aDir)})
        return acumulador
    }

    method agregarSiExiste(unaLista, unaDireccion) { 
        var acumulador = []
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
        var filtrado = game.getObjectsIn(unaDireccion.siguiente(pos))
        if(filtrado.any({obj => obj.kindName() != self.kindName()})){
            filtrado.remove(filtrado.find({obj => obj.kindName() != self.kindName()}))
        }
        return filtrado
    }

    method lindantes() {
        const dir = [arriba,abajo,der,izq]
        var acumulador = []
        dir.forEach({aDir => self.agregarSiExiste(acumulador, aDir)})
        return acumulador
    }

    method agregarSiExiste(unaLista, unaDireccion) { 
        var acumulador = []
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

    method instanciarObjetoDePrueba() {
        var obj = new ObjetoDePrueba()
        game.addVisual(obj)
        instancias.add(obj)
      
    }

    method instanciarAleatorio() {
        const bloques = [{self.instanciarSandia()}, {self.instanciarZanahoria()}, {self.instanciarManzana()}]
        bloques.randomize() 
        bloques.first().apply()
        console.println(instancias.size())
    }
}
