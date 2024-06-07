extends Area2D
signal hit
signal eat_mouse

@export var speed = 300;
@onready var animation_player = $AnimationPlayer
var screen_size;
var animation_hit
var initial_position
var hit_cat



func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move right"):
		velocity.x += 1
	if Input.is_action_pressed("move left"):
		velocity.x -=1
	if Input.is_action_pressed("move down"):
		velocity.y += 1
	if Input.is_action_pressed("move up"):
		velocity.y += -1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
		$AnimatedSprite2D2.play() 
	else : 
		$AnimatedSprite2D2.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$"AnimatedSprite2D2".animation = "lat"
		$"AnimatedSprite2D2".flip_h = velocity.x > 0
	if velocity.y != 0:
		$"AnimatedSprite2D2".animation = "up"


func _on_body_entered(body):
	hit_cat = false
	var script = body.get_script()
	var enemy_type = body.enemy_type
	if enemy_type == "bomb":
		play_damage_animation()
		GameManager.lose_live()
		if GameManager.lives == 0:
			rotation = 0
			$CollisionShape2D.set_deferred("disabled", true)
			hide()
			hit.emit()
		body.queue_free()
	if enemy_type != "bomb":
		GameManager.eat_mouse = true
		GameManager.score +=10
		body.play_animation()
		
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func play_damage_animation():
	animation_hit = get_node("AnimationPlayer")
	var damage_animation = animation_hit.get_animation("Damage_Animation")	
	
	#POSITION
	#damage_animation.add_track(Animation.TYPE_VALUE)
	#damage_animation.track_set_path(0, "position")
	
	damage_animation.track_insert_key(2, 0.0, position)
	damage_animation.track_insert_key(2, 0.1, position + Vector2(0, -10))
	damage_animation.track_insert_key(2, 0.2, position)
	
	animation_hit.play("Damage_Animation")
	


func _on_animation_player_animation_finished(anim_name):
	pass
	# Replace with function body.
