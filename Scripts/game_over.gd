extends Control

# Tela de Game Over
# Coloque esta cena em res://Cenas/game_over.tscn

@onready var btn_reiniciar: Button = $CenterContainer/VBoxContainer/BtnReiniciar
@onready var btn_menu: Button = $CenterContainer/VBoxContainer/BtnMenu
@onready var label_dica: Label = $CenterContainer/VBoxContainer/LabelDica

const DICAS = [
	"Dica: Observe o terreno antes de avançar!",
	"Dica: Atacar inimigos pelo ar causa mais dano.",
	"Dica: Destrua os baús para encontrar moedas!",
	"Dica: Cuidado com os espinhos — eles são fatais.",
	"Dica: Um pirata nunca desiste!",
]

func _ready() -> void:
	btn_reiniciar.pressed.connect(_on_reiniciar)
	btn_menu.pressed.connect(_on_menu)
	label_dica.text = DICAS[randi() % DICAS.size()]

func _on_reiniciar() -> void:
	GameManager.resetar()
	get_tree().change_scene_to_file("res://Cenas/fase.tscn")

func _on_menu() -> void:
	GameManager.resetar()
	get_tree().change_scene_to_file("res://Cenas/menu.tscn")
