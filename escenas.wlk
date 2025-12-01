import tablero.*
import wollok.game.*
import molly.*
import extras.*
import elementos.*
import SpriteAnimation.*

class Escena {

    const visuales = []
    const eventos = []
    const controles = []

    method iniciar() {
        self.dibujar()
        self.ejecutar()
    }

    method dibujar() {
        visuales.forEach({obj => game.addVisual(obj)})
    }
    
    method ejecutar() {
        eventos.forEach({com => com.start()})
        controles.forEach({com => com.apply()})
    }

    method limpiar() {
        game.clear()
        visuales.forEach({obj => game.removeVisual(obj)})
        eventos.forEach({tickEvent => tickEvent.stop()})
    }

    method siguienteEscena(escena) {
        self.limpiar()
        escena.iniciar()
    }

}
//-- INSTANCIAS -> -> ->

const menu = object {
    var property position = game.at(0,0)
    method image() = "menuinicio.png"
}

//Creando los eventos de la escena jugable
const spawnComidas = game.tick(2000, {spawner.instaciarComidaAleatoria()}, false)
const spawnDañino = game.tick(5000, {spawner.instanciarAlgunDañino()}, false)
const gravedadComida = game.tick(100, {spawner.instancias().forEach({unaComida => unaComida.descender()})}, false)
const gravedadMolly = game.tick(100, {molly.descender()}, false)
const cronometro = game.tick(1000,{tiempo.transcurrir()} , false)


//Creando la escena jugable 
const escPrincipal = new Escena(
    visuales = [
        molly,
        marco1,
        marco2,
        puntaje,
        tiempo
    ] + molly.vidas(),
    eventos = [
        spawnComidas,
        spawnDañino,
        gravedadComida,
        gravedadMolly,
        cronometro
    ],
    controles = [
        {keyboard.up().onPressDo({molly.saltar()})},
        {keyboard.left().onPressDo({molly.moverse(izq)})},
        {keyboard.right().onPressDo({molly.moverse(der)})},
        {keyboard.down().onPressDo({molly.soltarComida()})},
        {keyboard.z().onPressDo({molly.interactuar()})}
    ]
)


//Creando escena de pantalla principal
const escPantallaInicio = new Escena(
    visuales = [menu],
    eventos = [],
    controles = [
        {keyboard.enter().onPressDo(
        {escPantallaInicio.siguienteEscena(escPrincipal)})}
    ]
)

const escFinal = new Escena(
    visuales = [
        menuFinal,
        final],
    eventos = [],
    controles = []
)

const escPincho = new Escena (
    visuales = [pincho],
    eventos =[],
    controles = []
)


// PRUEBAS COLISIONES

const muroManzana0 = new Comida(tipo = manzana, position = game.at(14, 0))
const muroManzana1 = new Comida(tipo = manzana, position = game.at(14, 7))
const muroManzana2 = new Comida(tipo = manzana, position = game.at(14, 14))
const muroManzana3 = new Comida(tipo = manzana, position = game.at(14, 21))


const escColisiones = new Escena (
    visuales = [
        molly,
        muroManzana0,muroManzana1,muroManzana2,muroManzana3
    ],
    eventos = [
        gravedadMolly
        ],
    controles = [
        {keyboard.up().onPressDo({molly.saltar()})},
        {keyboard.left().onPressDo({molly.moverse(izq)})},
        {keyboard.right().onPressDo({molly.moverse(der)})},
        {keyboard.down().onPressDo({molly.soltarCaja()})},
        {keyboard.z().onPressDo({molly.sostenerCaja()})},
        {keyboard.space().onPressDo({molly.lanzarCaja()})}
        
    ]
)

const escSpritesAnimados = new Escena (
    visuales = [
        unaMazana,unaZanahoria,unaSandia
    ],
    eventos = [],
    controles = [
        {keyboard.space().onPressDo({   unaMazana.explotar()
                                        unaZanahoria.explotar()
                                        unaSandia.explotar()
        })}
    ]
)

const unaMazana = new Comida(tipo = manzana, position = game.at(60, 35))
const unaZanahoria = new Comida(tipo = zanahoria, position = game.at(14, 35))
const unaSandia = new Comida(tipo = sandia, position = game.at(0, 35))
const unaBomba = new Bomba(tipo = bomba, position = game.at(7, 35))

const escenaBombaEjemplo = new Escena(
    visuales = [
        unaBomba,
        unaZanahoria,
        unaSandia,
        molly
    ] + molly.vidas(),
    eventos = [

    ],
    controles = [
        {keyboard.up().onPressDo({molly.saltar()})},
        {keyboard.left().onPressDo({molly.moverse(izq)})},
        {keyboard.right().onPressDo({molly.moverse(der)})},
        {keyboard.down().onPressDo({molly.soltarCaja()})},
        {keyboard.z().onPressDo({molly.sostenerCaja()})},
        {keyboard.space().onPressDo({unaBomba.destruir()})}
    ]    
)

const escenaMollyDispara = new Escena(
    visuales = [
        molly
    ] + manzanas,
    eventos = [
        gravedadMolly,gravedadComida
    ],
    controles = [
        {keyboard.up().onPressDo({molly.saltar()})},
        {keyboard.left().onPressDo({molly.moverse(izq)})},
        {keyboard.right().onPressDo({molly.moverse(der)})},
        {keyboard.down().onPressDo({molly.soltarCaja()})},
        {keyboard.z().onPressDo({molly.interactuar()})}
    ]    
)
const manzanas = [ m1,m2,m3,m4]

const m1 = new Comida(tipo = manzana, position = game.at(7, 0))
const m2 = new Comida(tipo = manzana, position = game.at(14, 0))
const m3 = new Comida(tipo = manzana, position = game.at(21, 0))
const m4 = new Comida(tipo = zanahoria, position = game.at(0,0))