extends Node2D

var enemy_pos: Vector2

func _input(evt) -> void:
    if evt is InputEventMouseButton :
        if evt.pressed and evt.button_index == MOUSE_BUTTON_RIGHT :
            enemy_pos = evt.position
            
func _process(delta) -> void:
    enemy_pos = get_global_mouse_position()
    var theta := atan2( (enemy_pos.y - global_position.y), (enemy_pos.x - global_position.x) )
    rotation = theta
