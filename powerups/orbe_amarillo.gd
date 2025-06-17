extends Area2D

@export var tipo := "amarillo"

func _ready():
    $CollisionShape2D.set_deferred("disabled", false)

func _on_body_entered(cuerpo):
    if cuerpo.has_method("aplicar_mejora"):
        cuerpo.aplicar_mejora(tipo)
        queue_free()