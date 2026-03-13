extends Node2D

@onready var falling_key = preload("res://assets/rhytm/objects/falling_key.tscn")
@export var key_name: String = ""

var falling_key_queue = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if falling_key_queue.size() > 0: 
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
	
		if Input.is_action_just_pressed(key_name):
			var key_to_pop = falling_key_queue.pop_front()
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			print(distance_from_pass)
			key_to_pop.queue_free()

	

func CreateFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.Setup(position.x, $Sprite2D.frame + 4)
	
	falling_key_queue.push_back(fk_inst)




func _on_random_spawn_timer_timeout() -> void:
		CreateFallingKey()
		$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
		$RandomSpawnTimer.start()
