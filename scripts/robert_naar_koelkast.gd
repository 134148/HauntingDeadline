extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



var player_in_area = false

func _on_area_2d_body_entered(body):
	if body.name == "Robert":
		player_in_area = true

func _on_area_2d_body_exited(body):
	if body.name == "Robert":
		player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://scenes/robert_terug.tscn") # Replace with function body.
