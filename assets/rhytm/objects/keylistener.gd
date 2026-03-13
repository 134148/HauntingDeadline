extends Node2D

@onready var falling_key = preload("res://assets/rhytm/objects/falling_key.tscn")
@onready var score_text = preload("res://assets/rhytm/objects/score_press_text.tscn")
@export var key_name: String = ""

var falling_key_queue = []

#If distance less than thresshold, give that score
var perfect_press_threshold: float = 6
var great_press_threshold: float = 18
var good_press_threshold: float = 25
var ok_press_threshold: float = 40
#otherwise miss 

var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if falling_key_queue.size() > 0: 
		
		
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
			
			var st_inst = score_text.instantiate() 
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.SetTextInfo("MISS!")
			st_inst.global_position = global_position + Vector2(0, -15) 

	
		if Input.is_action_just_pressed(key_name):
			var key_to_pop = falling_key_queue.pop_front()
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			
			var press_score_text: String = ""
			if distance_from_pass < perfect_press_threshold: 
				Signals.IncrementScore.emit(perfect_press_threshold)
				press_score_text = "PERFECT!"
			elif distance_from_pass < great_press_threshold: 
				Signals.IncrementScore.emit(great_press_threshold)
				press_score_text = "GREAT!"
			elif distance_from_pass < good_press_threshold: 
				Signals.IncrementScore.emit(good_press_threshold)
				press_score_text = "GOOD!"
			elif distance_from_pass < ok_press_threshold: 
				Signals.IncrementScore.emit(ok_press_threshold)
				press_score_text = "OK!"
			else:
				press_score_text = "MISS!"
				pass


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
