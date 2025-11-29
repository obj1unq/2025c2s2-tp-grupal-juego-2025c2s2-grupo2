class SpriteAnimation{

    var animacion = []
    var isLoop = true
    var index = 0

    method setAnimation(_animacion) {
        animacion = _animacion
    }

    method reproducir() {
        if(index < animacion.size()) {index = index+1}
        if(index == animacion.size() && isLoop) {index = 0}
    }

    method sprite() {
        return animacion.get(index)
    }

    method haFinalizado() {
        return index == animacion.size() 
    }
}