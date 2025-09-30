extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = 700.0
@export var grav_const = 2000

func _physics_process(delta):
	var gravity: Vector2 = PhysicsServer2D.area_get_param(
		get_world_2d().get_space(),
		PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR
	)
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity.y * delta * grav_const
		velocity.x += gravity.x * delta * grav_const

	var up_vector: Vector2 = gravity.normalized() * -1

	# Handle jumping
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.x = jump_velocity * up_vector.x
		velocity.y = jump_velocity * up_vector.y

	# Get input direction
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
