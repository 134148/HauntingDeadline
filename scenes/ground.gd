extends Area2D

signal hit

func _on_body_entered(body):
	if body is CharacterBody2D:
		hit.emit()
