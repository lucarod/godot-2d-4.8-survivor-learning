extends Area2D

const IMPACT_SCENE: PackedScene = preload("res://pistol/impact/impact.tscn")

const SPEED: float = 1000
const RANGE: float = 1200
var travelled_distance: float = 0.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
		
func _spawn_impact() -> void:
	var impact: Node2D = IMPACT_SCENE.instantiate()
	get_tree().current_scene.add_child(impact)
	impact.global_position = global_position
	impact.rotation = randf() * TAU


func _on_body_entered(body: Node2D) -> void:
	_spawn_impact()
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
