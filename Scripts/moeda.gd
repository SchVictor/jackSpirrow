extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Registra esta moeda no total da fase
	GameManager.registrar_moeda_total()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		coletado()
		


func coletado():
	# 1. Avisa o sistema que pegou a moeda (sua lógica original)
	GameManager.coletar_moeda()
	
	# 2. Toca o som de coleta
	%SomMoeda.play()
	
	# 3. Esconde a imagem da moeda imediatamente (usando a variável que você já criou lá em cima!)
	animated_sprite_2d.visible = false
	
	# 4. Desliga a colisão para não pegar duas vezes
	$CollisionShape2D.set_deferred("disabled", true)
	
	# 5. Espera o som terminar de tocar
	await %SomMoeda.finished
	
	# 6. Apaga a moeda do jogo de verdade
	queue_free()
