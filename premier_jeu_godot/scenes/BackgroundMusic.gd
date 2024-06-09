extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.stream = preload("res://sound/background2.mp3")
	self.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	if not self.playing:
		self.play()
