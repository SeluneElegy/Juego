extends Node2D

@onready var enemigos = $Enemigos
@onready var jugador = $Jugador

func _on_Timer_timeout():
	var enemigo_escena = preload("res://mob.tscn")
	var nuevo_enemigo = enemigo_escena.instantiate()
	nuevo_enemigo.position = Vector2(
		randf_range(32, 608),
		randf_range(32, 328)
	)
	enemigos.add_child(nuevo_enemigo)
