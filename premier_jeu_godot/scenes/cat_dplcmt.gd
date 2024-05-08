extends Area2D
signal hit

@export var speed = 300;
var screen_size;

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
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
