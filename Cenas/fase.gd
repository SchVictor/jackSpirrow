extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_void_body_entered(body: Node2D) -> void:
		# Verifica se quem caiu no abismo foi o player
	if body.is_in_group("player"):
		# Chama a função de morte que já está pronta no seu player.gd
		if body.has_method("die"):
			body.die()
