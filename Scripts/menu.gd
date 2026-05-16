extends Control

# Menu Principal — Jack Espirrow
# Visual 100% via código: sem NinePatchRect, sem texturas de UI.
# Funciona independente de UIDs ou caminhos de assets.

@onready var btn_jogar: Button = $Fundo/Centro/Painel/VBox/BtnJogar
@onready var btn_sair:  Button = $Fundo/Centro/Painel/VBox/BtnSair
@onready var parallax:  ParallaxBackground = $Parallax

var scroll_speed := 40.0
var tempo: float = 0.0

func _ready() -> void:
	btn_jogar.pressed.connect(_on_jogar)
	btn_sair.pressed.connect(_on_sair)

func _process(delta: float) -> void:
	tempo += delta
	parallax.scroll_offset.x -= scroll_speed * delta
	# Ondulação sutil no painel — bob suave
	var painel = $Fundo/Centro/Painel
	painel.position.y = sin(tempo * 1.2) * 4.0

func _on_jogar() -> void:
	get_tree().change_scene_to_file("res://Cenas/fase.tscn")

func _on_sair() -> void:
	get_tree().quit()
