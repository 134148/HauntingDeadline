extends Node2D

var uren = 23
var minuten = 30
var speed = 1.0
var minute_accumulator = 0.0 
var time_up = false
var deur_text = false
@onready var text_display = %TheTekst

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
	if text_display.dialogue_active:
		return
	minute_accumulator += delta * speed
	if minute_accumulator >= 1.0:
		var add_minutes = int(minute_accumulator)
		minuten += add_minutes
		minute_accumulator -=add_minutes
		if minuten >= 60:
			uren = "00"
			minuten = "00"
			get_tree().reload_current_scene()
	$CanvasLayer/TijdDisplay/TijdText.text = str(uren) + ':' + str(minuten)
	
	if deur_text == true:
		$CanvasLayer/TextDisplay.show()
		text_display.dialogue_active = true
		$CanvasLayer/TextDisplay/TheTekst.text = "Oh nee de deur is dicht!"
		if Input.is_action_just_pressed("space"):
			%TextDisplay.hide()
			text_display.dialogue_active = false
			deur_text = false
	
	if player_in_area and Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://scenes/robert_terug.tscn")
		


func _on_deur_tekst_body_entered(body: Node2D) -> void:
	if body.name == "Robert":
		deur_text = true
