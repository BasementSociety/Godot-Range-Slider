# Godot Range Slider
An addon that provides two types of range sliders: A horizontal and a vertical one. With this node you are able to define a range inside of given minimum and maximum values. It lets you basically set the begin and end of a range with the mouse as well as moving the whole range up or down.
![Demo](/docs/demo.gif "Demo")

## Parameters
![Parameters](/docs/parameters.png "Parameters")

### Minimum
The minimum value defines the lowest value the range begin can have. It can be negative or positive.

### Maximum
The maximum value the range end can have. It can be negative or positive.

### Range Begin
The begin of the range. This value can be changes by clicking the corresponding handle of the gadget and dragging it around. It is constrained by the minimum parameter on the lower end and the current value of the Range End value minus the Minimum Range Size on the upper end.

### Range End
The end of the range. This value can be changes by clicking the corresponding handle of the gadget and dragging it around. It is constrained by the maximum parameter on the upper end and the current value of the Range Begin value plus the Minimum Range Size on the lower end.

### Range Minimum Size
A custom value that defines a minimum size of the range. If you set it to 5 for example, the delta between the Range Begin and the Range End values can not be less than 5.
Be cautious with too low values as the begin and end handles tend to overlap then and the node gets uncontrolable.

### BG Size
The thickness of the slider and the range marker.

### Handle Size
The diameter of the Range Begin and Range End handles.

### Colors
The background color, handle color and active handle color, which defines the color the handle and range have, if the mouse is over them or they are currently being dragged, can be defined here.
