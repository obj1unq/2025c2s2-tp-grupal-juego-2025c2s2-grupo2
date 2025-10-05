import wollok.game.*
import molly.*

class Comida {
    var property estaSiendoLevantada = false
    var property image = null
    var property position = null
    var property velocidad = null
    var property agarradaPor = null 
    var property tipo = null

    method descender() {  // Usar OnTick, va a caer gradualmente
        const objetosDebajo = game.getObjectsIn(position.down(7))
        if(position.y() > 0 && objetosDebajo.isEmpty()) {
            position = position.down(1)
        }
    }

    method agarrar(jugador) {
        self.estaSiendoLevantada(true)
        self.agarradaPor(jugador)
        // posicion inicial, justo encima
        self.position(game.at(jugador.position().x(), jugador.position().y() + 5))
    }

    method puntosQueOtorga(){
        return 20
    }



    //-----------------------------------------------------------------------

    const property grupo = #{}

    method añadirAGrupo() {
        const objArriba = game.getObjectsIn(position.up(7))
        const objAbajo  = game.getObjectsIn(position.down(7))
        const objIzq    = game.getObjectsIn(position.right(7))
        const objDer    = game.getObjectsIn(position.left(7))

        grupo.union(objAbajo.grupo())
        grupo.union(objArriba.grupo())
        grupo.union(objIzq.grupo())
        grupo.union(objDer.grupo())
    }

    method destruir() {
        grupo.forEach({elementos => elementos.destruir()})
        game.removeVisual(self)
    }
}

const variasComidas = []

    const manzana = new Comida(image = "manzana.png"
                ,position = game.at(self.posX() , 70 ),
                velocidad = 1,
                tipo = "manzana")
    const sandia =  new Comida(image = "sandia.png"
                ,position = game.at(self.posX() , 70 ),
                velocidad = 1,
                tipo = "sandia")
    const zanahoria =  new Comida(image = "BIGZANAHORIA.png"
                ,position = game.at(self.posX() , 70 ),
                velocidad = 1,
                tipo = "zanahoria") 

object spawner {

    //const ubicacionesPermitidas = [0,7,14,21,28,35,42,49,56,63,70,77,84,91,98,105,112,119,126]
    const alimentosSaludables = [manzana,sandia,zanahoria]

    method instanciar() {
        var ref = self.unaComidaAleatoria()
                
        variasComidas.add(
            new Comida(
                image = ref.image(),
                position = game.at(self.posX(),70),
                velocidad = ref.velocidad(),
                tipo = ref.tipo()
            )
        )
        console.println( "Se instancio una "+ref.tipo()+" Cantidad de Objetos = " + variasComidas.size())
        ref = null
    }

    method posX() {
        const rangoMinimo = 0
        const rangoMaximo = 126

        return (rangoMinimo.randomUpTo(rangoMaximo) / 7).truncate(0) * 7
    }

    method unaComidaAleatoria() {
        return alimentosSaludables.randomized().first()
    }
// -------------------------------------------


}
