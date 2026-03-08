extends CharacterBody2D

@export var movement_speed : float = 150
var character_direction : Vector2

func _physics_process(delta):

	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()

	# Flip sprites
	if character_direction.x > 0:
		%animatie_robert.flip_h = false
		%animatie_haar_r.flip_h = false
		%animatie_shirt_r.flip_h = false
		%animatie_broek_r.flip_h = false
		%animatie_schoenen_r.flip_h = false
	elif character_direction.x < 0:
		%animatie_robert.flip_h = true
		%animatie_haar_r.flip_h = true
		%animatie_shirt_r.flip_h = true
		%animatie_broek_r.flip_h = true
		%animatie_schoenen_r.flip_h = true

	# Movement
	if character_direction != Vector2.ZERO:
		velocity = character_direction * movement_speed
		
		if %animatie_robert.animation != "Walking":
			%animatie_robert.animation = "Walking"
		if %animatie_haar_r.animation != "hair_walking":
			%animatie_haar_r.play("hair_walking")
		if %animatie_shirt_r.animation != "shirt_walking":
			%animatie_shirt_r.play("shirt_walking")
		if %animatie_broek_r.animation != "broek_walking":
			%animatie_broek_r.play("broek_walking")
		if %animatie_schoenen_r.animation != "schoenen_walking":
			%animatie_schoenen_r.play("schoenen_walking")

	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		
		if %animatie_robert.animation != "Idle":
			%animatie_robert.animation = "Idle"
		if %animatie_haar_r.animation != "hair_idle":
			%animatie_haar_r.animation = "hair_idle"
		if %animatie_shirt_r.animation != "shirt_idle":
			%animatie_shirt_r.animation = "shirt_idle"
		if %animatie_broek_r.animation != "broek_idle":
			%animatie_broek_r.animation = "broek_idle"
		if %animatie_schoenen_r.animation != "schoenen_idle":
			%animatie_schoenen_r.animation = "schoenen_idle"

	move_and_slide()
