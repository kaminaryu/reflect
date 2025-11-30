extends Node

var used_grids: Dictionary

func pos_to_grid(pos:Vector2) -> Vector2 :
    return pos.snapped(Vector2(128, 128)) / Vector2(128, 128)

func add_to_grid(pos:Vector2) -> void :
    var grid_coords:Vector2 = pos_to_grid(pos)
    GridOrganizer.used_grids[grid_coords] = 0
    
    
func is_in_used_grid(pos) -> bool :
    var grid_coords:Vector2 = pos_to_grid(pos)
    if grid_coords in used_grids :
        return true
    return false
    


func _input(event: InputEvent) -> void:
    if event is InputEventKey :
        if event.pressed and event.keycode == KEY_Q :
            print("Used Grids: ", used_grids)
