extends Area2D

# VoidKiller — coloque esta cena bem abaixo do mapa (ex: y = 1500)
# Largura deve cobrir toda a extensão horizontal da fase.
# Mata o player instantaneamente ao cair no void.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Mata instantaneamente — ignora vida e iframes
		body.die()
