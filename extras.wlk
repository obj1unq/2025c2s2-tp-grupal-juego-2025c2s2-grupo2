import wollok.game.*
import molly.*
import comidas.*
import escenas.*


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

object arriba {
    method siguiente(position){
        return position.up(7)
    }
}

object abajo {
    method siguiente(position){
        return position.down(7)
    }
}

object puntaje {
   var property position = game.at(8, 66)
   method text () = "PUNTOS:" + " " + molly.puntos()
}

object marcoPuntaje {
    var property position = game.at(4, 65)
    method image() = "marquito.png"
}

class Corazon {
    var property position
    const estaFeliz

    method image(){
        if (estaFeliz){
            return "corazoncitofeliz.png"
        }
        else{
            return "corazoncitotrite.png"
        }
    }

}

object tiempo {
    var property position = game.at (123, 68)
    var property segundos = 180

    method minutos() = segundos.div(60) 
    method segundos() = segundos - (self.minutos() * 60)
    method text () = " " + self.minutos() + ":" + self.segundos()

    method transcurrir() {
      if(segundos == 0){
        escPrincipal.siguienteEscena(escFinal)
      } else {
        segundos -= 1
      }
    }
}

object final {
    var property position = game.center()  
    method text() = "juego terminado, tus puntos son " + molly.puntos()
}


