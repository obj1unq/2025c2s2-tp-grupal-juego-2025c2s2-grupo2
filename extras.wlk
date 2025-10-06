import wollok.game.*
import molly.*
import comidas.*

object piso {
    var property position = game.at(0, 0)
    var property image = "piso.png" 
}

object izq {
    method nombreDir() {
        return "izq"
    }
    method siguiente(position){
        return position.left(7)
    }
    method estaMirandoMolly(){
        return molly.mirandoA() == self
    }
}

object der {
    method nombreDir() {
        return "der"
    }
    method siguiente(position){
        return position.right(7)
    }
    method estaMirandoMolly(){
        return molly.mirandoA() == self
    }
}

object puntaje {
   var property position = game.at(4, 68)
   method text () = "PUNTOS:" + " " + molly.puntos()
}

object marcoPuntaje {
    var property position = game.at(4, 65)
    method image() = "marquito.png"
}

class Corazon {
    var property position = null
    const estaFeliz = true

    method image(){
        if (estaFeliz){
            return "corazoncitofeliz.png"
        }
        else{
            return "corazoncitotrite.png"
        }
    }

}

object tiempo { //TERMINAR!!
    var property position = game.at (123, 68)
    var property segundos = 0
    var property minutos = segundos.div(60)
    method text () = " " + minutos + ":" + segundos
    method transcurrir(){
        if (minutos != 3 && segundos < 60){
            segundos += 1
            minutos = segundos.div(60)
        }
        else if (minutos != 3){
            segundos = 0
        }
        else{
            game.stop()
        }
    }
}


