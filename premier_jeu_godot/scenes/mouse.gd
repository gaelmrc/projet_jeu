extends RigidBody2D

var enemy_type : String
var animation_hit

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var animation = mob_types[randi() % mob_types.size()]
	enemy_type = animation
	var mob_position = GameManager.mob_position 
	GameManager.update_animation(animation)
	if animation != "bomb":
		if mob_position<0.2: 
			$AnimatedSprite2D.play("vertical")
		elif mob_position<0.5:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("horizontal")
		elif mob_position<0.7:
			$AnimatedSprite2D.play("vertical")
		else :
			$AnimatedSprite2D.play("horizontal")
	else : 
		$AnimatedSprite2D.play("bomb")
		$BTimer.start()
		
func _on_position_updated(new_position):
	print("Nouvelle position reçue : ", new_position)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_b_timer_timeout():
	queue_free() 

#func play_animation():
#	animation_hit = get_node("AnimationPlayer")
#	var damage_animation = animation_hit.get_animation("mouse_hit")	
#	
#	damage_animation.track_insert_key(1, 0.0, position)
#	damage_animation.track_insert_key(1, 0.1, position + Vector2(0, -10))
#	damage_animation.track_insert_key(1, 0.2, position)
#	
#	animation_hit.play("mouse_hit")
