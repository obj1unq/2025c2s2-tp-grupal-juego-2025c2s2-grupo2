import wollok.game.*
import molly.*
import escenas.*
import elementos.*

class Direccion {
    method nombreDir() //se sobreescribe en las direcciones
    method siguiente(position) //se sobreescribe en las direcciones
    method estaMirandoMolly(){
        return molly.mirandoA() == self
    } //se sobreescribe en las direcciones
}

object izq inherits Direccion {
    override method nombreDir() {
        return "izq"
    }
    
    override method siguiente(position){
        return position.left(7)
    }
}

object der inherits Direccion{
    override method nombreDir() {
        return "der"
    }

    override method siguiente(position){
        return position.right(7)
    }
}

object arriba inherits Direccion{
    override method siguiente(position){
        return position.up(7)
    }

    override method nombreDir() {
        return "arriba"
    }
}

object abajo inherits Direccion{
    override method siguiente(position){
        return position.down(7)
    }

    override method nombreDir() {
        return "arriba"
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
    var estaFeliz

    method image(){
        if (estaFeliz){
            return "corazoncitofeliz.png"
        }
        else{
            return "corazoncitotrite.png"
        }
    }

    method cambiarEstado() {
        estaFeliz = !estaFeliz
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

