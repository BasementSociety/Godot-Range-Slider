class_name RangeSlider
extends Control


## Signals used by this node
signal changed(range_begin : float, range_end : float)


## The minimum value defines the lowest value the range begin can have. It can be negative or positive.
@export var minimum : float = 0:
	set(value):
		minimum = value
		if minimum > range_begin:
			range_begin = minimum
		if maximum - minimum < range_min_size:
			range_min_size = maximum - minimum
		queue_redraw()
	get:
		return minimum

## The maximum value the range end can have. It can be negative or positive.		
@export var maximum : float = 100:
	set(value):
		maximum = value
		if maximum < range_end:
			range_end = maximum
		if maximum - minimum < range_min_size:
			range_min_size = maximum - minimum
		queue_redraw()
	get:
		return maximum

## The begin of the range. This value can be changes by clicking the corresponding handle of the gadget and dragging it around. 
## It is constrained by the minimum parameter on the lower end and the current value of the Range End value minus the Minimum Range Size on the upper end.
@export var range_begin : float = 40:
	set(value):
		range_begin = value
		if range_begin < minimum:
			range_begin = minimum
		queue_redraw()
	get:
		return range_begin

## The end of the range. This value can be changes by clicking the corresponding handle of the gadget and dragging it around. 
## It is constrained by the maximum parameter on the upper end and the current value of the Range Begin value plus the Minimum Range Size on the lower end.
@export var range_end : float = 60:
	set(value):
		range_end = value
		if range_end > maximum:
			range_end = maximum
		queue_redraw()
	get:
		return range_end

## A custom value that defines a minimum size of the range. If you set it to 5 for example, the delta between the Range Begin and the Range End values can not be less than 5.
## Be cautious with too low values as the begin and end handles tend to overlap then and the node gets uncontrolable.
@export var range_min_size : float = 10:
	set(value):
		range_min_size = value
		if range_min_size > maximum - minimum:
			range_min_size = maximum - minimum
		queue_redraw()
	get:
		return range_min_size

## The thickness of the slider and the range marker.
@export var bg_size : int = 8

## The diameter of the Range Begin and Range End handles.
@export var handle_size : int = 15


@export_group("Colors")
@export var background_color : Color = Color.DIM_GRAY
@export var handle_color : Color = Color.DARK_GRAY
@export var handle_active_color : Color = Color.LIGHT_GRAY


## The current local mouse position
var mouse_pos : Vector2
## The current state of the left mouse button
var lmb : bool
## Is the Range Begin handle currently dragged?
var min_moving : bool
## Is the Range End handle currently dragged?
var max_moving : bool
## Is the whole range currently dragged?
var range_moving : bool
## The offset of the mouse position to the Range Begin position
var offset : float
## The delta between the Begin and End values
var current_range : float
## Defines if the slider is drawn vertically
var vertical : bool = true


func _ready() -> void:
	# Do a first draw of the node on initialization
	queue_redraw()

	
func _input(event):
	# Only redraw the node if a mouse input was detected
	if event is InputEventMouseMotion:
		mouse_pos = get_local_mouse_position()
		queue_redraw()
		

func _draw() -> void:
	# Remember if the left mouse button is currently being pressed
	var lmb : bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)

	# Remember the last begin and end values to determin at the end of this function if any of the values was changed
	var old_begin : float = range_begin
	var old_end : float = range_end
	
	# Values based on if the node is drawn horizontally or vertically
	var range_size_pixel : float = size.y if vertical else size.x
	var thickness_pixel : float = size.x if vertical else size.y
	var mouse_pos_range : float = mouse_pos.y if vertical else mouse_pos.x
	var mouse_pos_thickness : float = mouse_pos.x if vertical else mouse_pos.y

	# Remember the current range size and the positions of the begin and end handles
	var whole_range : float = abs(maximum - minimum)
	var range_min_pos : float = (range_begin - minimum) / whole_range * (range_size_pixel - bg_size) + bg_size / 2
	var range_max_pos : float = (range_end - minimum) / whole_range * (range_size_pixel - bg_size) + bg_size / 2
	
	# Detect if the mouse is over any of the handles
	var min_hover : bool = false
	var max_hover : bool = false
	var range_hover : bool = false
	if !min_moving and !max_moving and !range_moving:
		if mouse_pos_thickness >= thickness_pixel / 2 - (handle_size / 2 + 1) and mouse_pos_thickness <= thickness_pixel / 2 + (handle_size / 2 + 1):
			min_hover = mouse_pos_range >= range_min_pos - (handle_size / 2 + 1) and mouse_pos_range <= range_min_pos + (handle_size / 2 + 1)
			max_hover = mouse_pos_range >= range_max_pos - (handle_size / 2 + 1) and mouse_pos_range <= range_max_pos + (handle_size / 2 + 1)
			range_hover = mouse_pos_range >= range_min_pos + (handle_size / 2 + 1) and mouse_pos_range <= range_max_pos - (handle_size / 2 + 1)

	# Determin what handle is currently changed if the mouse button is pressed
	if lmb:
		if min_hover:
			min_moving = true
		if max_hover:
			max_moving = true
		if range_hover:
			range_moving = true
			offset = mouse_pos_range - range_min_pos
			current_range = abs(range_end - range_begin)
	else:
		min_moving = false
		max_moving = false
		range_moving = false
					
	# Calculate new values if any of the handles is changed/dragged
	if min_moving:
		range_begin = minimum + mouse_pos_range / range_size_pixel * whole_range
		if range_begin > range_end - range_min_size:
			range_begin = range_end - range_min_size
	
	if max_moving:
		range_end = minimum + mouse_pos_range / range_size_pixel * whole_range
		if range_end < range_begin + range_min_size:
			range_end = range_begin + range_min_size
	
	if range_moving:
		range_begin = minimum + (mouse_pos_range - offset) / range_size_pixel * whole_range
		range_end = range_begin + current_range
		if range_end >= maximum:
			range_end = maximum
			range_begin = maximum - current_range
		elif range_end <= minimum:
			range_begin = minimum
			range_end = minimum + current_range
		
	# Clamp both the begin and end values to the minimum and maximum constraints
	range_begin = clampf(range_begin, minimum, maximum)
	range_end = clampf(range_end, minimum, maximum)
		
	# Define the slider beckground
	var bg : StyleBoxFlat = StyleBoxFlat.new()
	bg.set_corner_radius_all(bg_size)
	bg.bg_color = background_color

	# Define the range grabber
	var handle : StyleBoxFlat = StyleBoxFlat.new()
	handle.set_corner_radius_all(handle_size)
	handle.bg_color = handle_active_color if range_hover or range_moving else handle_color

	# Draw everything
	if vertical:
		draw_style_box(bg, Rect2(Vector2(size.x / 2 - bg_size / 2, 0), Vector2(bg_size, size.y)))
		draw_style_box(handle, Rect2(Vector2(size.x / 2 - bg_size / 2, range_min_pos), Vector2(bg_size, range_max_pos - range_min_pos)))
		draw_circle(Vector2(size.x / 2.0 + 0.5, range_min_pos), handle_size / 2, handle_active_color if min_hover or min_moving else handle_color, true, -1.0, true)
		draw_circle(Vector2(size.x / 2.0 + 0.5, range_max_pos), handle_size / 2, handle_active_color if max_hover or max_moving else handle_color, true, -1.0, true)
	else:
		draw_style_box(bg, Rect2(Vector2(0, size.y / 2 - bg_size / 2), Vector2(size.x, bg_size)))
		draw_style_box(handle, Rect2(Vector2(range_min_pos, size.y / 2 - bg_size / 2), Vector2(range_max_pos - range_min_pos, bg_size)))
		draw_circle(Vector2(range_min_pos, size.y / 2.0 + 0.5), handle_size / 2, handle_active_color if min_hover or min_moving else handle_color, true, -1.0, true)
		draw_circle(Vector2(range_max_pos, size.y / 2.0 + 0.5), handle_size / 2, handle_active_color if max_hover or max_moving else handle_color, true, -1.0, true)

	# If any of the range values changed emit the changed signal
	if old_begin != range_begin or old_end != range_end:
		changed.emit(range_begin, range_end)
	
