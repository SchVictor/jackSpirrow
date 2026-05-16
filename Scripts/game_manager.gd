extends Node

# GameManager — Autoload Singleton
# Project > Project Settings > Autoload
# Nome: GameManager | Path: res://Scripts/game_manager.gd

signal game_over
signal vitoria
signal vida_alterada(atual: int, maximo: int)
signal moeda_coletada(total: int)

var moedas_coletadas: int = 0
var moedas_total: int = 0
var tentativas: int = 0

func registrar_moeda_total() -> void:
	moedas_total += 1

func coletar_moeda() -> void:
	moedas_coletadas += 1
	moeda_coletada.emit(moedas_coletadas)

func atualizar_vida(atual: int, maximo: int) -> void:
	vida_alterada.emit(atual, maximo)

func resetar() -> void:
	moedas_coletadas = 0
	moedas_total = 0

func acionar_game_over() -> void:
	tentativas += 1
	game_over.emit()
	get_tree().call_deferred("change_scene_to_file", "res://Cenas/game_over.tscn")

func acionar_vitoria() -> void:
	vitoria.emit()
	get_tree().call_deferred("change_scene_to_file", "res://Cenas/vitoria.tscn")
