extends Control

@onready var h_range_slider_0_100: HRangeSlider = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HRangeSlider_0_100
@onready var label_begin_0_100: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Label_Begin_0_100
@onready var label_end_0_100: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Label_End_0_100

@onready var h_range_slider_10_10: HRangeSlider = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HRangeSlider_10_10
@onready var label_begin_10_10: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Label_Begin_10_10
@onready var label_end_10_10: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Label_End_10_10

@onready var v_range_slider_0_100: VRangeSlider = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/VRangeSlider_0_100
@onready var v_label_begin_0_100: Label = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/Label_Begin_0_100
@onready var v_label_end_0_100: Label = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/Label_End_0_100

@onready var v_range_slider_10_10: VRangeSlider = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/VRangeSlider_10_10
@onready var v_label_begin_10_10: Label = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/HBoxContainer/Label_Begin_10_10
@onready var v_label_end_10_10: Label = $MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/HBoxContainer/Label_End_10_10


func _ready() -> void:
	label_begin_0_100.text = "Range Begin: " + str(h_range_slider_0_100.range_begin)
	label_end_0_100.text = "Range End: " + str(h_range_slider_0_100.range_end)

	label_begin_10_10.text = "Range Begin: " + str(h_range_slider_10_10.range_begin)
	label_end_10_10.text = "Range End: " + str(h_range_slider_10_10.range_end)

	v_label_begin_0_100.text = "Range Begin: " + str(v_range_slider_0_100.range_begin)
	v_label_end_0_100.text = "Range End: " + str(v_range_slider_0_100.range_end)

	v_label_begin_10_10.text = "Range Begin: " + str(v_range_slider_10_10.range_begin)
	v_label_end_10_10.text = "Range End: " + str(v_range_slider_10_10.range_end)


func _on_h_range_slider_0_100_changed(range_begin : float, range_end : float) -> void:
	label_begin_0_100.text = "Range Begin: " + str(range_begin)
	label_end_0_100.text = "Range End: " + str(range_end)


func _on_h_range_slider_10_10_changed(range_begin: float, range_end: float) -> void:
	label_begin_10_10.text = "Range Begin: " + str(range_begin)
	label_end_10_10.text = "Range End: " + str(range_end)


func _on_V_range_slider_0_100_changed(range_begin: float, range_end: float) -> void:
	v_label_begin_0_100.text = "Range Begin: " + str(range_begin)
	v_label_end_0_100.text = "Range End: " + str(range_end)


func _on_v_range_slider_10_10_changed(range_begin: float, range_end: float) -> void:
	v_label_begin_10_10.text = "Range Begin: " + str(range_begin)
	v_label_end_10_10.text = "Range End: " + str(range_end)
