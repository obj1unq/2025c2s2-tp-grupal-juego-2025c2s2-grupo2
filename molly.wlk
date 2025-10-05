import wollok.game.*
import extras.*
import comidas.*


object molly {
    var property mirandoA = "der"
    var property position = game.at(0, 0)
    var property vidas = 3
    var property puntos = 0
    var property cajaLevantada = null 
    
    method image() = "molly-" + mirandoA + ".png"

    method sostenerCaja() {
        const px = self.position().x()
        const py = self.position().y()
        const cell = 5
        // umbrales: 3 celdas en X, 2 celdas en Y (ajustalos si hace falta)
        const maxDistX = cell * 3
        const maxDistY = cell * 2

        console.println("sostenerCaja: Molly en " + px + "@" + py + 
                        " mirandoDerecha:" + derecha.estaMirando() + 
                        " mirandoIzquierda:" + izquierda.estaMirando())

        const comidasCerca = variasComidas.filter({ comida =>
            const cx = comida.position().x()
            const cy = comida.position().y()
            const dx = (px - cx).abs()
            const dy = (py - cy).abs()

            // sólo considerar comidas que estén hacia donde mira Molly
            const facingOk = (derecha.estaMirando() and cx >= px) or
                            (izquierda.estaMirando() and cx <= px) or
                            (not derecha.estaMirando() and not izquierda.estaMirando()) // fallback

            const colision = facingOk and dx <= maxDistX and dy <= maxDistY

            console.println("  Chequeando comida en " + cx + "@" + cy +
                            " => dx:" + dx + " dy:" + dy +
                            " facingOk:" + facingOk + " colision:" + colision)
            colision
        })

        if (comidasCerca.isEmpty()) {
            console.println("  -> No hay comidas cercanas para agarrar (umbrales: X<=" + maxDistX + " Y<=" + maxDistY + ")")
        }

        // elegir la comida más cercana en X (para evitar agarrar una más lejana)
        var mejor = comidasCerca.first()
        var mejorDist = (px - mejor.position().x()).abs()
        comidasCerca.forEach({ c =>
            const d = (px - c.position().x()).abs()
            if (d < mejorDist) {
                mejor = c
                mejorDist = d
            }
        })

        console.println("  -> Agarrando comida en " + mejor.position())
        mejor.agarrar(self)
    }

    method lanzarCaja() {
        
    }

    method moverseDerecha() {
        mirandoA = "der"
        self.validarMoverseDerecha()
        celdas.verificarMovimientoMolly(game.at(self.position().x() + 5, self.position().y()), "derecha")
        position = game.at(self.position().x() + 5, self.position().y())
    }

    method moverseIzquierda() {
        mirandoA = "izq"
        self.validarMoverseIzquierda()
        celdas.verificarMovimientoMolly(game.at(self.position().x() - 5, self.position().y()), "izquierda")
        position = game.at(self.position().x() - 5, self.position().y())
    }


    method validarMoverseDerecha() {
        if (self.position().x() == game.height() - 1){
            self.error("esta en un borde por ende no se puede mover")
        }
    }

    method validarMoverseIzquierda() {
        if (self.position().x() == 0){
            self.error("esta en un borde por ende no se puede mover")
        }
    }

    method saltar() {
        position = game.at(position.x(), position.y() + 5)
    }

    method descender() {
        if(position.y() > 0){
            position = game.at(position.x(), position.y() - 1)  
        }
    }
}