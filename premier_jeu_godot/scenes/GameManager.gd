extends	Node

var mob_position
var current_animation
var bomb_destroy
var lives = 0
var score = 0
var eat_mouse = false


signal position_updated(new_position)

func lose_live():
	lives -=1

func update_position(new_position):
	mob_position = new_position

func update_animation(animation):
	current_animation = animation

func bomb_timer_end(boolean):
	bomb_destroy = boolean

