extends CharacterBody2D

signal health_depleted

const MAX_HEALTH: float = 100.0
const DAMAGE_RATE: float = 5.0
const SPEED: float = 600.0

var health: float = MAX_HEALTH
var _is_dead: bool = false

func _ready() -> void:
	%ProgressBar.max_value = MAX_HEALTH

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()

	if velocity != Vector2.ZERO:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()

	var overlapping_mobs: Array[Node2D] = %HurtBox.get_overlapping_bodies()
	if not overlapping_mobs.is_empty():
		health = maxf(health - DAMAGE_RATE * overlapping_mobs.size() * delta, 0.0)
		%ProgressBar.value = health
		if health <= 0.0 and not _is_dead:
			_is_dead = true
			health_depleted.emit()
