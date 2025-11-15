import wollok.game.*
import molly.*
import extras.*
import comidas.*
import bomba.*

scene mainScene {

    // ---------- VARIABLES DE LA ESCENA ----------
    var vida1
    var vida2
    var vida3

    // ---------- INICIALIZACIÓN ----------
    init {
        game.title("patoJuego")
        game.width(126)
        game.height(70)
        game.cellSize(10)

        // Visuales principales
        add(molly)
        add(marcoPuntaje)
        add(puntaje)
        add(tiempo)

        // --- Crear vidas ---
        vida1 = new Corazon(position = game.at(game.width()/2+10, game.height()-7), estaFeliz = true)
        vida2 = new Corazon(position = game.at(game.width()/2, game.height()-7),     estaFeliz = true)
        vida3 = new Corazon(position = game.at(game.width()/2-10, game.height()-7),  estaFeliz = false)

        molly.vidas([vida1, vida2, vida3])

        molly.vidas().forEach({ vida =>
            add(vida)
        })

        // ---------- EVENTOS ----------
        // TIMERS
        game.onTick(5000, "spawn comidas", {
            spawner.instanciarAleatorio()
        })

        game.onTick(100, "gravedad comida", {
            spawner.instancias().forEach({ unaComida =>
                unaComida.descender()
            })
        })

        game.onTick(100, "gravedad molly", {
            molly.descender()
        })

        game.onTick(1000, "tiempo", {
            tiempo.transcurrir()
        })

        game.onTick(100, "lanzar", {
            molly.lanzandoCaja()
        })

        // ---------- CONTROLES ----------
        onKeyDown {
            if(key == "up") molly.saltar()
            if(key == "left") molly.moverse(izq)
            if(key == "right") molly.moverse(der)
            if(key == "z") molly.sostenerCaja()
            if(key == "down") molly.soltarCaja()
            if(key == "space") molly.lanzarCaja()
        }
    }
}
