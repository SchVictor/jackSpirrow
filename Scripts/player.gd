extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = 400.0
@export var vida_max = 10
@export var dano = 2

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var attack_area: Area2D = $AttackArea
@onready var timer: Timer = $Timer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float
var atacando : bool
var vida: int = vida_max
var is_dead: bool = false
var levando_hit: bool = false

const NUMERO_COLLISION = 24

func _process(_delta):
	if is_dead:
		return
	animate()
	flip()

func flip():
	if velocity.x > 0:
		$Sprite2D.flip_h = false
		$AttackArea/Collision.position.x = NUMERO_COLLISION
	if velocity.x < 0:
		$Sprite2D.flip_h = true
		$AttackArea/Collision.position.x = -NUMERO_COLLISION

func animate():
	if is_dead:
		animation.play("death")
		return
	if levando_hit:
		animation.play("hit")
		return
	if atacando:
		animation.play("attack 01")
		return
	if velocity.y > 0 and not is_on_floor():
		animation.play("fall")
		return
	if velocity.y < 0 and not is_on_floor():
		animation.play("jump")
		return
	if velocity.x != 0:
		animation.play("run")
		return
	if velocity.x == 0:
		animation.play("idle")
		return

func _physics_process(delta):
	gravidade(delta)
	mover()

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		jump()
	if Input.is_action_pressed("ataque"):
		ataque()
	direction = Input.get_axis("esquerda", "direita")

func mover():
	velocity.x = direction * speed
	move_and_slide()

func gravidade(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta

func jump():
	velocity.y = -jump_velocity

func ataque():
	atacando = true

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack 01":
		atacando = false
	if anim_name == "death":
		timer.start()
	if anim_name == "hit":
		levando_hit = false

func take_damage(amount: int):
	if is_dead:
		return
	vida -= amount
	if vida <= 0:
		die()
	else:
		levando_hit = true
		animation.play("hit")

func die():
	is_dead = true
	animation.play("death")
	velocity = Vector2.ZERO

func _on_attack_area_body_entered(body):
	if body.is_in_group("inimigo") and atacando:
		body.take_damage(dano)

func _on_timer_timeout():
	# Agora chama o GameManager em vez de recarregar a cena diretamente
	GameManager.acionar_game_over()


func _on_area_fim_body_entered(body):
	if body.is_in_group("player"):
		GameManager.acionar_vitoria()
		get_tree().change_scene_to_file("res://Cenas/vitoria.tscn")
