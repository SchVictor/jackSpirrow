extends Control

# Tela de Vitória
# Coloque esta cena em res://Cenas/vitoria.tscn

@onready var btn_menu: Button = $CenterContainer/VBoxContainer/BtnMenu
@onready var btn_reiniciar: Button = $CenterContainer/VBoxContainer/BtnReiniciar
@onready var label_moedas: Label = $CenterContainer/VBoxContainer/LabelMoedas

func _ready() -> void:
	btn_menu.pressed.connect(_on_menu)
	btn_reiniciar.pressed.connect(_on_reiniciar)

	# Mostra quantas moedas foram coletadas
	var coletadas = GameManager.moedas_coletadas
	var total = GameManager.moedas_total
	if total > 0:
		label_moedas.text = "Moedas coletadas: %d / %d" % [coletadas, total]
	else:
		label_moedas.text = ""

func _on_menu() -> void:
	GameManager.resetar()
	get_tree().change_scene_to_file("res://Cenas/menu.tscn")

func _on_reiniciar() -> void:
	GameManager.resetar()
	get_tree().change_scene_to_file("res://Cenas/fase.tscn")
