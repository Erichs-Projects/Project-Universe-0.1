extends Camera2D

# Camera Control
@export var SPEED = 10.0
@export var ZOOM_SPEED = 20.0
@export var ZOOM_MARGIN = 0.1
@export var ZOOM_MIN = 1.5
@export var ZOOM_MAX = 5.0

var zoomFactor = 1.0
var zoomPos = Vector2()
var zooming = false

var mousePos: Vector2 = Vector2()
var mousePosGlobal: Vector2 = Vector2()




func _ready():
	pass

func _process(delta):
	
	var inputX = 0
	var inputY = 0
	inputX += int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	inputY += int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	
	position.x = lerp(position.x, position.x + inputX * SPEED * zoom.x, SPEED*delta)
	position.y = lerp(position.y, position.y + inputY * SPEED * zoom.y, SPEED*delta)
	
	
	zoom.x = lerp(zoom.x, zoom.x * zoomFactor, ZOOM_SPEED * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomFactor, ZOOM_SPEED * delta)
	
	zoom.x = clamp(zoom.x, ZOOM_MIN, ZOOM_MAX)
	zoom.y = clamp(zoom.y, ZOOM_MIN, ZOOM_MAX)
	
	if not zooming:
		zoomFactor = 1.0
	
		


func _input(event):
	
	if abs(zoomPos.x - get_global_mouse_position().x) > ZOOM_MARGIN:
		zoomFactor = 1.0
	if abs(zoomPos.y - get_global_mouse_position().y) > ZOOM_MARGIN:
		zoomFactor = 1.0
		
	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.is_action("WheelDown"):
				zoomFactor -= 0.01 * ZOOM_SPEED
				zoomPos = get_global_mouse_position()
			if event.is_action("WheelUp"):
				zoomFactor += 0.01 * ZOOM_SPEED
				zoomPos = get_global_mouse_position()

		else:
			zooming	= false
			
	
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()
		
