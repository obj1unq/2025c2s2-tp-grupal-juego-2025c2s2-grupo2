import wollok.game.*
import molly.*

scene endScene {
    var mensaje = ""
    var mostrarPuntaje = 0

    init {
        // opcional: agregar un objeto estático o texto
        add(new EndText(), width/2 - 220, height/2 - 40)
    }

    // método público para setear datos que vienen de mainScene
    method setFinalData(win) {
        if (win) {
            mensaje = "¡Ganaste! Puntaje: " + molly.puntaje()
        } else {
            mensaje = "Perdiste. Puntaje: " + molly.puntaje()
        }
        // forzar redraw del texto si lo necesitás
    }

    onKeyDown {
        if (key == "enter") {
            // reiniciar la escena principal y volver a ella
            mainScene.reset()
            game.setScene(mainScene)
        } else if (key == "escape") {
            // volver a la pantalla de inicio
            game.setScene(startScene)
        }
    }
}

class EndText {
    method shape() = text(endScene.mensaje + "\n\nPresiona ENTER para volver a jugar\nESC para menú", 20)
    method color() = white()
}
