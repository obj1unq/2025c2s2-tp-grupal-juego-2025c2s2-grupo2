import wollok.game.*

scene startScene {
    init {
        add(new StartText(), width/2 - 200, height/2 - 20)
    }

    onKeyDown {
        if (key == "enter") {
            // resetear estado de main antes de arrancar
            mainScene.reset()
            game.setScene(mainScene)
        }
    }
}

class StartText {
    method shape() = text("PRESIONA ENTER PARA COMENZAR", 24)
    method color() = white()
}
