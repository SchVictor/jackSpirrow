extends CanvasLayer

# HUD — instanciar como filho de fase.tscn
# Escuta sinais do GameManager e atualiza automaticamente.

@onready var coracao_container: HBoxContainer = %CoracaoContainer
@onready var label_moedas: Label = %LabelMoedas

const CORACAO_CHEIO  = "❤"
const CORACAO_VAZIO  = "🖤"

var vida_max_atual: int = 0

func _ready() -> void:
	GameManager.vida_alterada.connect(_on_vida_alterada)
	GameManager.moeda_coletada.connect(_on_moeda_coletada)
	_on_moeda_coletada(0)

func _on_vida_alterada(atual: int, maximo: int) -> void:
	vida_max_atual = maximo
	_desenhar_coracoes(atual, maximo)

func _on_moeda_coletada(total: int) -> void:
	label_moedas.text = str(total)

func _desenhar_coracoes(atual: int, maximo: int) -> void:
	# Limpa corações anteriores
	for filho in coracao_container.get_children():
		filho.queue_free()

	# Recria um Label por ponto de vida
	for i in range(maximo):
		var label = Label.new()
		label.text = CORACAO_CHEIO if i < atual else CORACAO_VAZIO
		label.add_theme_font_size_override("font_size", 20)
		coracao_container.add_child(label)
