extends CanvasLayer

signal start_game

func _ready():
	$ScoreLabel.hide()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("GAME OVER")
	await $MessageTimer.timeout
	
	$Message.text = "TRY AGAIN ?"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	$Titre.hide()
	$ScoreLabel.show()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
