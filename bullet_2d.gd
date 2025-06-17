extends Area2D

var distancia = 0
var daño = 1.0

func _physics_process(delta):
	var velocidad = 1000
	var alcance = 1200
	position += Vector2.RIGHT.rotated(rotation) * velocidad * delta
	distancia += velocidad * delta
	if distancia > alcance:
		queue_free()

func _on_body_entered(cuerpo):
	if cuerpo.has_method("recibir_dano"):
		cuerpo.recibir_dano()
	queue_free()