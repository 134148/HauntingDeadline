extends Node

@export var pipe_scene : PackedScene

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
	screen_size = get_window().size
	ground_height = $Computer/Ground/Ground1.texture.get_height()
	new_game()

func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	pipes.clear()
	#generate pipes
	generate_pipes()
	$Computer/Bird.reset()
	
func _input(event):
	if game_over == false:
		if Input.is_action_just_pressed("space"):
			if game_running == false:
				start_game()
			else:
				if $Computer/Bird.flying:
					$Computer/Bird.flap()
					check_top()

						
func start_game():
	game_running = true
	$Computer/Bird.flying = true
	$Computer/Bird.flap()
	$Pipe_timer.start()
	
func _process(delta) :
	if game_running:
	
		for ground in $Computer/Ground.get_children():
			ground.position.x -= SCROLL_SPEED
		
			if ground.position.x < -ground.texture.get_width():
				ground.position.x += ground.texture.get_width() * 2
		
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	pass
	
#func _on_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/robert_naar_koelkast.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/robert_naar_koelkast.tscn") # Replace with function body.


func _on_pipe_timer_timeout() -> void:
	generate_pipes()

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	var pipe_y = (screen_size.y - ground_height) / 2
	pipe.position.y = pipe_y + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	add_child(pipe)
	pipes.append(pipe)
	
func check_top():
	if $Computer/Bird.position.y < -600:
		$Computer/Bird.falling = true
		stop_game()

func stop_game():
	$Pipe_timer.stop()
	$Computer/Bird.flying = false
	game_running = false
	game_running = true

	
func bird_hit():
	$Computer/Bird.falling = true
	stop_game()
