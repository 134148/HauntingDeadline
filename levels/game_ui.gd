extends Control

@onready var end_message = $CanvasLayer/EndMessage
@onready var retry_button = $CanvasLayer/RetryButton
@onready var timer_label = $CanvasLayer/TimerLabel

var score: int = 0
var combo_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)
	end_message.visible = false
	retry_button.visible = false
	
	ResetCombo()


func IncrementScore(incr: int):
	score += incr
	$CanvasLayer/ScoreLabel.text = str(score) + "pts"
	
func IncrementCombo():
	combo_count += 1
	%ComboLabel.text = " " + str(combo_count) + "x combo"
	
func ResetCombo():
	combo_count = 0
	%ComboLabel.text = ""


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene() # Replace with function body.


func show_game_over():
	$CanvasLayer/EndMessage.text = "Game over"
	$CanvasLayer/EndMessage.visible = true
	$CanvasLayer/RetryButton.visible = true


func show_win():
	$CanvasLayer/EndMessage.text = "Goed gedaan! Je hebt het op tijd ingeleverd en je hebt een tien"
	$CanvasLayer/EndMessage.visible = true
	$CanvasLayer/RetryButton.visible = true

func update_timer(time_left: float):
	$CanvasLayer/TimerLabel.text = str(max(0, ceil(time_left)))
