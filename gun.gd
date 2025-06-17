extends Area2D

func _ready():
	$Timer.timeout.connect(_on_Timer_timeout)

func _process(_delta):
	var enemigos = get_overlapping_bodies()
	if enemigos.size() > 0:
		var objetivo = enemigos.front()
		look_at(objetivo.global_position)

func disparar():
	var bala_escena = preload("res://bullet_2d.tscn")
	var jugador = get_parent()
	if not jugador.has("estadisticas"):
		return
	var dispersion = int(jugador.estadisticas["dispersion"])
	var angulo_base = rotation
	for i in range(dispersion):
		var separacion = deg_to_rad((i - dispersion / 2.0) * 10)
		var nueva_bala = bala_escena.instantiate()
		nueva_bala.global_transform = $PuntoDisparo.global_transform
		nueva_bala.rotation = angulo_base + separacion
		nueva_bala.daño = jugador.estadisticas["daño"]
		get_tree().current_scene.add_child(nueva_bala)

func _on_Timer_timeout():
	disparar()
