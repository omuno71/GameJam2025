extends Area2D

var is_on: bool = false
var player_in_range: bool = false
@onready var player_node: CharacterBody2D = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		flip()
	
	if is_on:
		print("on")
		change_gravity_to(0, -1)
	else:
		print("off")
		change_gravity_to(0, 1)

func flip():
	is_on = !is_on
	

func change_gravity_to(x: float, y: float):
	PhysicsServer2D.area_set_param(
		get_world_2d().get_space(),
		PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR,
		Vector2(x, y)
	)
	
	player_node.up_direction = Vector2(-x, -y)

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		player_in_range = true


func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		player_in_range = false
