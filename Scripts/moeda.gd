extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Registra esta moeda no total da fase
	GameManager.registrar_moeda_total()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		coletado()

func coletado():
	GameManager.coletar_moeda()
	queue_free()
