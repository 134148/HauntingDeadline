extends Node2D

@onready var anim = $AnimationPlayer
@onready var glow_overlay = $GlowOverlay
@onready var falling_key = preload("res://assets/rhytm/objects/falling_key.tscn")
@onready var score_text = preload("res://assets/rhytm/objects/score_press_text.tscn")
@onready var combo_label = $CanvasLayer/ComboLabel

@export var key_name: String = ""

var falling_key_queue = []

var game_time := 0.0
var game_running := true
var total_score := 0

# If distance less than threshold, give that score
var perfect_press_threshold: float = 6
var great_press_threshold: float = 18
var good_press_threshold: float = 25
var ok_press_threshold: float = 40
# otherwise miss

var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

func _ready():
	$GlowOverlay.frame = $Sprite2D.frame + 4
	Signals.IncrementScore.connect(_on_score_added)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !game_running:
		return

	game_time += delta

	if total_score >= 3000 or game_time >= 60.0:
		_end_game()
		return

	if falling_key_queue.size() > 0:
		if falling_key_queue.front().has_passed:
			var missed_key = falling_key_queue.pop_front()
			if missed_key != null:
				missed_key.queue_free()

			Signals.ResetCombo.emit()

		if Input.is_action_just_pressed(key_name):
			if falling_key_queue.is_empty():
				return

			var key_to_pop = falling_key_queue.pop_front()
			if key_to_pop == null:
				return

			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)

			anim.stop()
			anim.play("key_hit")

			var press_score_text: String = ""

			if distance_from_pass < perfect_press_threshold:
				Signals.IncrementScore.emit(perfect_press_score)
				press_score_text = "PERFECT!"
				Signals.IncrementCombo.emit()

			elif distance_from_pass < great_press_threshold:
				Signals.IncrementScore.emit(great_press_score)
				press_score_text = "GREAT!"
				Signals.IncrementCombo.emit()

			elif distance_from_pass < good_press_threshold:
				Signals.IncrementScore.emit(good_press_score)
				press_score_text = "GOOD!"
				Signals.IncrementCombo.emit()

			elif distance_from_pass < ok_press_threshold:
				Signals.IncrementScore.emit(ok_press_score)
				press_score_text = "OK!"
				Signals.IncrementCombo.emit()

			else:
				press_score_text = "MISS!"
				Signals.ResetCombo.emit()

			key_to_pop.queue_free()

			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.SetTextInfo(press_score_text)
			st_inst.global_position = global_position + Vector2(0, -15)

func CreateFallingKey():
	if !game_running:
		return

	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.Setup(position.x, $Sprite2D.frame + 4)

	falling_key_queue.push_back(fk_inst)

func _on_random_spawn_timer_timeout() -> void:
	if !game_running:
		return

	CreateFallingKey()
	$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
	$RandomSpawnTimer.start()

func _on_score_added(incr: int) -> void:
	total_score += incr

func _end_game() -> void:
	game_running = false
	$RandomSpawnTimer.stop()
	print("GAME OVER")
