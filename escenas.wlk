import wollok.game.*
import molly.*
import extras.*
import comidas.*
import bomba.*

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
        eventos.forEach({com => com.ejecutar()})
        controles.forEach({com => com.apply()})
    }

    method limpiar() {
        game.clear()
        visuales.forEach({obj => game.removeVisual(obj)})
        eventos.forEach({obj => game.removeTickEvent(obj.nombre())})
    }

    method siguienteEscena(escena) {
        self.limpiar()
        escena.iniciar()
    }

}

class Evento {
    const tiempo = 0
    const nombreDelEvento = "un nombre bonito"
    const comando = {}

    method nombre() = nombreDelEvento  
    method ejecutar() {game.onTick(tiempo, nombreDelEvento, comando)}

}

//-- INSTANCIAS -> -> ->


const vida1 = new Corazon(position = game.at(126/2+10, 70-7), estaFeliz = true) // Corazon de la izquierda
const vida2 = new Corazon(position = game.at(126/2, 70-7), estaFeliz = true)    // Corazon del medio
const vida3 = new Corazon(position = game.at(126/2-10, 70-7), estaFeliz = false) // Corazon de la derecha


const menu = object {
    var property position = game.at(0,0)
    method image() = "menuinicio.png"
}

//Creando los eventos de la escena jugable
const spawnComidas = new Evento(
    tiempo = 5000,
    nombreDelEvento = "spawnComidas",
    comando = {spawner.instanciarAleatorio()})

const gravedadComida = new Evento(
    tiempo = 100,
    nombreDelEvento = "gravedadComida",
    comando = {spawner.instancias().forEach({unaComida => unaComida.descender()})})

const gravedadMolly = new Evento(
    tiempo = 100,
    nombreDelEvento = "gravedadMolly",
    comando = {molly.descender()})

const cronometro = new Evento(
    tiempo = 1000,
    nombreDelEvento = "cronometro",
    comando = {tiempo.transcurrir()})

const lanzar = new Evento(
    tiempo = 100,
    nombreDelEvento = "lanzar",
    comando = {molly.lanzandoCaja()})

const eventoFinal = new Evento(
    tiempo = 0,
    nombreDelEvento = "final",
    comando = {
        game.removeTickEvent("spawn comidas")
        game.removeTickEvent("gravedad comida")
        game.removeTickEvent("gravedad molly")
        game.removeTickEvent("tiempo")
        game.addVisual(final)}
)

//Creando la escena jugable 
const escPrincipal = new Escena(
    visuales = [
        molly,
        marcoPuntaje,
        puntaje,
        tiempo,
        vida1,
        vida2,
        vida3
    ],
    eventos = [
        spawnComidas,
        gravedadComida,
        gravedadMolly,
        cronometro,
        lanzar
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
    visuales = [],
    eventos = [eventoFinal],
    controles = []
)

