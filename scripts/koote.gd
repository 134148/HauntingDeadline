extends CharacterBody2D

var speed = 25
var player_chase = true
var player = null  # node reference

@onready var text_display = %TheTekst

func _ready():
	var scene_root = get_tree().current_scene
	
	# check direct children
	if scene_root.has_node("Robert"):
		player = scene_root.get_node("Robert")
	elif scene_root.has_node("Kiara"):
		player = scene_root.get_node("Kiara")
	elif scene_root.has_node("Daria"):
		player = scene_root.get_node("Daria")
		
func _physics_process(delta: float) -> void:
	if text_display.dialogue_active:
		return
	if player_chase and player != null:
		# richting naar speler
		var direction = (player.position - position).normalized()
		# beweging
		position += direction * speed * delta
		move_and_collide(Vector2(0,0))
