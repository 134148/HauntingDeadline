extends Node2D

var uren = 23
var minuten = 30
var speed = 1.0
var minute_accumulator = 0.0 
var time_up = false
var deur_text = false
var player_in_area = false
var dead := false
@onready var text_display = %TheTekst

#geheime doorgang niet te zien
func _ready() -> void:
	for child in %DoorgangTilemap.get_children():
		child.hide()
	%YouDied.hide()
	%TijdDisplay.show()
	%RestartText.hide()

#check of player in area
func _on_volgende_level_body_entered(body):
	if body.name == "Robert":
		player_in_area = true
func _on_volgende_level_body_exited(body):
	if body.name == "Robert":
		player_in_area = false

#gebeurt elke frame
func _process(delta):
	if text_display.dialogue_active:
		return
	#crazy klok	
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
	
	#NIET WERKEND tekst als je naar de deur gaat
	if deur_text == true:
		$CanvasLayer/TextDisplay.show()
		text_display.dialogue_active = true
		$CanvasLayer/TextDisplay/TheTekst.text = "Oh nee de deur is dicht!"
		if Input.is_action_just_pressed("space"):
			%TextDisplay.hide()
			text_display.dialogue_active = false
			deur_text = false
	
	#Volgende level
	if player_in_area and Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://scenes/endgame.tscn")
		
	# Reload als dood
	if dead and Input.is_action_just_pressed("space"):
		get_tree().reload_current_scene()
		

#NIET WERKEND als je deur probeert te gebruiken
func _on_deur_tekst_body_entered(body: Node2D) -> void:
	if body.name == "Robert":
		deur_text = true

# Laat de geheime doorgang zien
func _on_geheime_doorgang_body_entered(body: Node2D) -> void:
	if body.name == "Robert":
		for child in %DoorgangTilemap.get_children():
			child.show() # Replace with function body.

# Dood door Koote
func _on_koote_area_body_entered(body: Node2D) -> void:
	if body.name == "Robert":
		dead = true
		$AudioStreamPlayer2D.stream = load("res://assets/music/Clement Panchout _ Unsettling victory _ 2019.wav")
		$AudioStreamPlayer2D.play()
		%YouDied.show()
		%TijdDisplay.hide() # Replace with function body.
		%RestartText.show()
			
