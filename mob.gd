extends CharacterBody2D

const MAX_HEALTH: int = 3
const SPEED: float = 300.0
const SMOKE_SCENE: PackedScene = preload("res://smoke_explosion/smoke_explosion.tscn")

var health: int = MAX_HEALTH

@onready var _player: CharacterBody2D = get_node("/root/Game/Player")

func _ready() -> void:
	%Slime.play_walk()

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = global_position.direction_to(_player.global_position)
	velocity = direction * SPEED
	move_and_slide()

func take_damage() -> void:
	health -= 1
	%Slime.play_hurt()
	if health <= 0:
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
