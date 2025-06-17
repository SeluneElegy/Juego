extends CharacterBody2D

var velocidad = 90
var vida = 3
var jugador
var grafo
var ruta = []
var actual = 0

func _ready():
	var lista = get_tree().get_nodes_in_group("jugador")
	if lista.size() > 0:
		jugador = lista[0]
	grafo = get_node("/root/Juego/Grafo")
	_calcular_ruta()

func _physics_process(delta):
	if ruta.size() == 0:
		return

	var objetivo = grafo.nodos[ruta[actual]]
	var direccion = (objetivo - global_position).normalized()
	velocity = direccion * velocidad
	move_and_slide()

	if global_position.distance_to(objetivo) < 10.0:
		actual += 1
		if actual >= ruta.size():
			_calcular_ruta()

func _calcular_ruta():
	if jugador and grafo:
		var desde = grafo.encontrar_mas_cercano(global_position)
		var hasta = grafo.encontrar_mas_cercano(jugador.global_position)
		ruta = grafo.buscar_ruta(desde, hasta)
		actual = 0

func recibir_dano():
	vida -= 1
	if vida == 0:
		var orbes = [
			preload("res://powerups/orbe_rojo.tscn"),
			preload("res://powerups/orbe_verde.tscn"),
			preload("res://powerups/orbe_amarillo.tscn"),
			preload("res://powerups/orbe_morado.tscn")
		]
		var orbe = orbes[randi() % orbes.size()].instantiate()
		orbe.global_position = global_position
		get_tree().current_scene.add_child(orbe)
		queue_free()
