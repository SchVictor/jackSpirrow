extends Control

@onready var btn_reiniciar: Button = $CenterContainer/Painel/Margem/VBox/BtnReiniciar
@onready var btn_menu: Button = $CenterContainer/Painel/Margem/VBox/BtnMenu
@onready var label_stats: Label = $CenterContainer/Painel/Margem/VBox/LabelStats



func _ready() -> void:
	btn_reiniciar.pressed.connect(_on_reiniciar)
	btn_menu.pressed.connect(_on_menu)
	label_stats.text = "Moedas coletadas: %d    Tentativas: %d" % [
		GameManager.moedas_coletadas,
		GameManager.tentativas
	]

func _on_reiniciar() -> void:
	GameManager.resetar()
	get_tree().change_scene_to_file("res://Cenas/fase.tscn")

func _on_menu() -> void:
	GameManager.resetar()
	get_tree().change_scene_to_file("res://Cenas/menu.tscn")
