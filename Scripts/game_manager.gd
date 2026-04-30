extends Node

# GameManager - Autoload Singleton
# Adicionar em: Project > Project Settings > Autoload
# Nome: GameManager | Path: res://Scripts/game_manager.gd

signal game_over
signal vitoria

var moedas_coletadas: int = 0
var moedas_total: int = 0

func registrar_moeda_total():
	moedas_total += 1

func coletar_moeda():
	moedas_coletadas += 1

func resetar():
	moedas_coletadas = 0
	moedas_total = 0

func acionar_game_over():
	game_over.emit()

func acionar_vitoria():
	vitoria.emit()
