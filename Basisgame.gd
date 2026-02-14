extends Node2D

#!!!!!!!deze code heb ik van Daria's link in ons klad, dus hij is gwn van internet!

# Declare member variables here.
var player
var enemies
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	add_enemies()
	get_player_details()

func add_enemies():
	pass # Add code to do this later

func get_player_details():
	pass # Add the code later

# Called every frame.
func _process(delta):
	process_inputs(delta)
	process_enemy_activity(delta)
	update_score()

func process_inputs(delta):
	pass

func process_enemy_activity(delta):
	pass

func update_score():
	pass
