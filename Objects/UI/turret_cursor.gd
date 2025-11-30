extends Node2D

func _process(delta: float) -> void:
    global_position = get_global_mouse_position().snapped(Vector2(128, 128)) 
    
    if GridOrganizer.is_in_used_grid(global_position) :
        modulate = Color(0.67, 0, 0, 0.5)
    else :
        modulate = Color(0, 0.67, 0, 0.5)
