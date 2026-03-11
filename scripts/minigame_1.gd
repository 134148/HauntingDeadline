extends Node

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 4
var screen_size : Vector2i
var ground_height : int
var pipes : Array
var PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200


# Called when the node enters the scene tree for the first time.
func _ready() :
	new_game()

func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$Computer/Bird.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Computer/Bird.flying:
						$Computer/Bird.flap()
						
func start_game():
	game_running = true
	$Computer/Bird.flying = true
	$Computer/Bird.flap()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	pass
	
#func _on_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/robert_naar_koelkast.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/robert_naar_koelkast.tscn") # Replace with function body.
