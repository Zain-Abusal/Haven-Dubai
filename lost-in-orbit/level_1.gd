extends Node2D

@export var scroll_speed: float = 140.0

@onready var bg_1 = $Bg
@onready var bg_2 = $Bg2

var background_width: float

func _ready():
	background_width = get_viewport_rect().size.x
	
	bg_1.position.x = 0
	bg_2.position.x = background_width

func _process(delta):
	bg_1.position.x -= scroll_speed * delta
	bg_2.position.x -= scroll_speed * delta
	
	if bg_1.position.x + background_width / 2 <= 0:
		bg_1.position.x = bg_2.position.x + background_width
		
	if bg_2.position.x + background_width / 2 <= 0:
		bg_2.position.x = bg_1.position.x + background_width 
