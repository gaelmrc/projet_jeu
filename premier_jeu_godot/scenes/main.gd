extends Node

@export var mob_scene : PackedScene

var heart1
var heart2
var heart3
var animation_player
var game_over_sprite

func _ready():
	heart1 = get_node("HeartsContainer/Heart1")
	heart2 = get_node("HeartsContainer/Heart2")
	heart3 = get_node("HeartsContainer/Heart3")
	game_over_sprite = get_node("GameOver_anim")
	animation_player = $GameOver_anim/AnimationPlayer 
	game_over_sprite.visible = false

func _process(delta):
	$HUD.update_score(GameManager.score)
	if GameManager.lives == 3:
		heart1.visible = true
		heart2.visible = true
		heart3.visible = true
	elif GameManager.lives == 2:
		heart1.visible = true
		heart2.visible = true
		heart3.visible = false
	elif GameManager.lives == 1:
		heart1.visible = true
		heart2.visible = false
		heart3.visible = false
	elif GameManager.lives == 0:
		heart1.visible = false
		heart2.visible = false
		heart3.visible = false
		
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	game_over_sprite.visible = true
	var sound_gameover = get_node("GameOver_anim/AudioStreamPlayer2D")
	sound_gameover.play()
	animation_player.play("Game_over")
	
		
func new_game():
	GameManager.score = 0
	$Cat.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(GameManager.score)
	$HUD.show_message("GET READY")
	
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	GameManager.lives = 3

func _on_score_timer_timeout():
	GameManager.score += 1
	$HUD.update_score(GameManager.score)
	
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	GameManager.update_position(mob_spawn_location.progress_ratio)
	var direction = mob_spawn_location.rotation + PI/2;
	mob.position = mob_spawn_location.position;
	
	var velocity = Vector2(randf_range(150.0,250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)
	

func _on_hud_start_game():
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Game_over":
		$HUD.show_game_over()


