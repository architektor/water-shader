@tool
extends Sprite2D

func _process(_delta):
	_zoom_changed()

func _zoom_changed():
	material.set("shader_parameter/y_zoom", get_viewport_transform().get_scale().y)

func _on_item_rect_changed():
	material.set("shader_parameter/scale", scale)
