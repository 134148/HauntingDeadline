extends CharacterBody2D

const GRAVITY = 1000
const MAX_VEL = 600
const FLAP_SPEED = -400
var flying = false
var falling = false
#var velocity = Vector2.ZERO
const START_POS = Vector2(100, 300)  # zorg dat dit binnen je scherm is

func _ready():
	reset()

func reset():
	falling = false
	velocity = Vector2.ZERO   # ingebouwde velocity
	position = START_POS
	set_rotation(0)
	flying = false  # pas true bij start_game of flap

func flap():
	velocity.y = FLAP_SPEED
	flying = true

func _physics_process(delta):
	if flying or falling:
		velocity.y += GRAVITY * delta
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL

		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()

		move_and_slide()  # Godot 4: geen argumenten
	else:
		$AnimatedSprite2D.stop()
