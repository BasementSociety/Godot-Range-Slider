@tool
@icon("res://IconV.svg")
class_name VRangeSlider
extends RangeSlider


func _ready() -> void:
	# Do a first draw of the node on initialization
	vertical = true
	queue_redraw()
