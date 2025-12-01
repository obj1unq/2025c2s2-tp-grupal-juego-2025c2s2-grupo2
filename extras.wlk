import wollok.game.*
import molly.*
import escenas.*
import elemento.*

class Direccion {
    method nombreDir() 
    method siguiente(position) 
    method estaMirandoMolly(){
        return molly.mirandoA() == self
    } 
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
   var property position = game.at(12, 66)
   method text () = "PUNTOS:" + " " + molly.puntos()
   method textColor() = "#000000"
}

class MarcoPuntaje {
    var property position
    method image() = "marquitonew.png"
}
const marco1 = new MarcoPuntaje(position = game.at(4, 65))
const marco2 = new MarcoPuntaje(position = game.at(105, 65))

class Corazon {
    var property position
    var property estaFeliz 

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
    var property position = game.at (112, 66)
    var property segundos = 180

    method minutos() = segundos.div(60) 
    method segundos() = segundos - (self.minutos() * 60)
    method text () = " " + self.minutos() + ":" + self.segundos()
    method textColor() = "#000000"

    method transcurrir() {
      if(segundos == 0){
        escPrincipal.siguienteEscena(escFinal)
      } else {
        segundos -= 1
      }
    }
}

object final {
    var property position = game.at (63, 20)  
    method text() = "Tus puntos son " + molly.puntos()
}

object menuFinal {
    var property position = game.at(0,0)
    method image() = "menufinal.png"  
}
