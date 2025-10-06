import wollok.game.*
import molly.*
import comidas.*

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
