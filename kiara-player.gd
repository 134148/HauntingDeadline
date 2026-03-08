extends CharacterBody2D

@export var movement_speed : float = 150
var character_direction : Vector2

func _physics_process(delta):

	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()

	# Flip sprites
	if character_direction.x > 0:
		%animatie_kiara.flip_h = false
		%animatie_haar_k.flip_h = false
		%animatie_shirt_k.flip_h = false
		%animatie_broek_k.flip_h = false
		%animatie_schoenen_k.flip_h = false
	elif character_direction.x < 0:
		%animatie_kiara.flip_h = true
		%animatie_haar_k.flip_h = true
		%animatie_shirt_k.flip_h = true
		%animatie_broek_k.flip_h = true
		%animatie_schoenen_k.flip_h = true

	# Movement
	if character_direction != Vector2.ZERO:
		velocity = character_direction * movement_speed
		
		if %animatie_kiara.animation != "Walking":
			%animatie_kiara.animation = "Walking"
		if %animatie_haar_k.animation != "hair_walking":
			%animatie_haar_k.play("hair_walking")
		if %animatie_shirt_k.animation != "shirt_walking":
			%animatie_shirt_k.play("shirt_walking")
		if %animatie_broek_k.animation != "broek_walking":
			%animatie_broek_k.play("broek_walking")
		if %animatie_schoenen_k.animation != "schoenen_walking":
			%animatie_schoenen_k.play("schoenen_walking")

	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		
		if %animatie_kiara.animation != "Idle":
			%animatie_kiara.animation = "Idle"
		if %animatie_haar_k.animation != "hair_idle":
			%animatie_haar_k.animation = "hair_idle"
		if %animatie_shirt_k.animation != "shirt_idle":
			%animatie_shirt_k.animation = "shirt_idle"
		if %animatie_broek_k.animation != "broek_idle":
			%animatie_broek_k.animation = "broek_idle"
		if %animatie_schoenen_k.animation != "schoenen_idle":
			%animatie_schoenen_k.animation = "schoenen_idle"

	move_and_slide()
