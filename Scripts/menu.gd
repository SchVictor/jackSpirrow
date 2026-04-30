extends Control

# Menu Principal - Jack Espirrow

@onready var btn_jogar: Button = $CenterContainer/VBoxContainer/BtnJogar
@onready var btn_sair: Button = $CenterContainer/VBoxContainer/BtnSair
@onready var parallax: ParallaxBackground = $ParallaxBackground

var scroll_speed := 60.0

func _ready() -> void:
	btn_jogar.pressed.connect(_on_jogar_pressed)
	btn_sair.pressed.connect(_on_sair_pressed)

func _process(delta: float) -> void:
	# Anima o fundo se movendo lentamente
	parallax.scroll_offset.x -= scroll_speed * delta

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/fase.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()
