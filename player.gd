extends CharacterBody2D

signal health_depleted

var vida = 100.0

var estadisticas = {
	"daño": 1.0,
	"cadencia": 1.0,
	"dispersion": 1.0,
	"velocidad": 600.0
}

func _physics_process(delta):
	var direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direccion * estadisticas["velocidad"]
	move_and_slide()

	for cuerpo in $ZonaGolpe.get_overlapping_bodies():
		if cuerpo.is_in_group("enemigos"):
			vida -= 6.0 * delta
		if vida <= 0:
			emit_signal("health_depleted")

func aplicar_mejora(tipo):
	match tipo:
		"rojo":
			estadisticas["daño"] += 0.5
		"verde":
			estadisticas["cadencia"] *= 0.9
		"amarillo":
			estadisticas["dispersion"] += 1.0
		"morado":
			estadisticas["velocidad"] += 50

func _process(_delta):
	if has_node("BarraFondo/BarraVida"):
		var barra = $BarraFondo/BarraVida
		barra.size.x = 24.0 * clamp(vida / 100.0, 0, 1)
