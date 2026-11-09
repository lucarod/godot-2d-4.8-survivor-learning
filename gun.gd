extends Area2D

const BULLET_SCENE: PackedScene = preload("res://bullet.tscn")
const MUZZLE_FLASH_SCENE: PackedScene = preload("res://pistol/muzzle_flash/muzzle_flash.tscn")

func _physics_process(_delta: float) -> void:
	var enemies_in_range: Array[Node2D] = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy: Node2D = enemies_in_range.front()
		look_at(target_enemy.global_position)
		
func _spawn_bullet() -> void:
	var new_bullet: Node2D = BULLET_SCENE.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	
func _spawn_muzzle_flash() -> void:
	var muzzle_flash: Node2D = MUZZLE_FLASH_SCENE.instantiate()
	%ShootingPoint.add_child(muzzle_flash)
	muzzle_flash.rotation = randf_range(-0.12, 0.12)


func shoot() -> void:
	_spawn_bullet()
	_spawn_muzzle_flash()

func _on_timer_timeout() -> void:
	shoot()
