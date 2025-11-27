extends Node2D

@onready

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton :
        if event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE :
            
