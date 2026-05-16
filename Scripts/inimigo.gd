extends CharacterBody2D

const SPEED = 100.0
const VIDA_MAX = 10
const DANO = 1

@export var direction := -1
@onready var animation: AnimationPlayer = $Animation
@onready var ray: RayCast2D = $Ray
@onready var collision: CollisionShape2D = $AttackArea/Collision
# CORREÇÃO: referências às colisões do próprio corpo e da área de ataque
@onready var body_collision: CollisionShape2D = $CollisionShape2D
@onready var attack_area: Area2D = $AttackArea

var atacando: bool
var vida: int = VIDA_MAX
var is_dead: bool = false
var levando_hit: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if is_dead or levando_hit:
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	if not atacando:
		if ray.is_colliding():
			direction *= -1
			ray.scale.x *= -1
			flip()

	if direction and not atacando:
		velocity.x = direction * SPEED
		animation.play("run")
	else:
		velocity.x = 0

	move_and_slide()

func flip():
	# CORREÇÃO: usar direction em vez de velocity.x para o flip,
	# já que velocity.x é zerado durante o ataque.
	$Sprite2D.flip_h = direction > 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_dead: 
		return
		
	if body.is_in_group("player"):
		atacando = true
		body.take_damage(DANO)
		
		# Só troca a animação para ataque se ele não estiver apanhando
		if not levando_hit:
			animation.play("attack")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if is_dead: 
		return
		
	if body.is_in_group("player"):
		atacando = false
		
		# Só troca a animação para corrida se ele não estiver apanhando
		if not levando_hit:
			animation.play("run")

func _on_animation_finished(anim_name: StringName) -> void:
	if is_dead:
		return # Não deixa outras animações interferirem se já morreu 
			
	if anim_name == "attack":
		if atacando:
			animation.play("attack")
		else:
			animation.play("run")
	elif anim_name == "hit":
		levando_hit = false
		if atacando:
			animation.play("attack")
		else:
			animation.play("run")

func take_damage(amount: int):
	# Guarda dupla igual ao player — ignora dano se morto ou em hit
	if is_dead or levando_hit:
		return
	vida -= amount
	if vida <= 0:
		die()
	else:
		levando_hit = true
		animation.play("hit")

func die():
	is_dead = true
	velocity = Vector2.ZERO
	call_deferred("_desativar_colisoes")
	
	print("Inimigo: die() ativado! Tocando 'death'...")
	animation.play("death")
	
	# A MÁGICA ACONTECE AQUI: 
	# Forçamos o código a esperar a animação terminar por conta própria, 
	# sem depender das conexões da aba "Sinais" do editor!
	await animation.animation_finished
	
	print("Inimigo: Animação terminou! Sumindo com o nó...")
	queue_free()

func _desativar_colisoes() -> void:
	# Desativa a colisão do corpo (para de bloquear o player fisicamente)
	if body_collision:
		body_collision.set_deferred("disabled", true)
	# Desativa o hitbox de ataque (para de causar dano pós-morte)
	if collision:
		collision.set_deferred("disabled", true)
	# Desativa a área de detecção de ataque por completo
	if attack_area:
		attack_area.monitorable = false
		attack_area.monitoring = false
