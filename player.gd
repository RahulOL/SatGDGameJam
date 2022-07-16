extends KinematicBody2D


export (int) var speed = 700
export (int) var jump_speed = 1200
export (int) var gravity = 3000
var velocity = Vector2.ZERO

onready var animsprite = $AnimatedSprite

func get_input():
	velocity.x = 0
	#Ugly Animation Handling :V
	if velocity.y != 0:
		animsprite.play("Jump")
		if Input.is_action_pressed("ui_right"):
				animsprite.set_flip_h(false)
				velocity.x += speed
		elif Input.is_action_pressed("ui_left"):
				animsprite.set_flip_h(true)
				velocity.x -= speed
	else:
		if Input.is_action_pressed("ui_right"):
			animsprite.set_flip_h(false)
			animsprite.play("Run")
			velocity.x += speed
		elif Input.is_action_pressed("ui_left"):
			animsprite.set_flip_h(true)
			animsprite.play("Run")
			velocity.x -= speed
		else:
			animsprite.play("Idle")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = -jump_speed

	


func _on_Node2D3_body_entered(body):
	get_tree().change_scene("res://level 3.tscn")
