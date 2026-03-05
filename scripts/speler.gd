extends CharacterBody2D

@export var movement_speed : float = 150
var character_direction : Vector2

func _physics_process(delta):

	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()

	# Flip sprites
	if character_direction.x > 0:
		%animatie_speler.flip_h = false
		%animatie_haar.flip_h = false
	elif character_direction.x < 0:
		%animatie_speler.flip_h = true
		%animatie_haar.flip_h = true

	# Movement
	if character_direction != Vector2.ZERO:
		velocity = character_direction * movement_speed
		
		if %animatie_speler.animation != "Walking":
			%animatie_speler.animation = "Walking"
		if %animatie_haar.animation != "hair_walking":
			%animatie_haar.play("hair_walking")

	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		
		if %animatie_speler.animation != "Idle":
			%animatie_speler.animation = "Idle"
		if %animatie_haar.animation != "hair_idle":
			%animatie_haar.animation = "hair_idle"

	move_and_slide()
