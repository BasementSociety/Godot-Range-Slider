@tool
@icon("res://addons/RangeSlider/IconH.svg")
class_name HRangeSlider
extends RangeSlider


func _ready() -> void:
	# Do a first draw of the node on initialization
	vertical = false
	queue_redraw()
