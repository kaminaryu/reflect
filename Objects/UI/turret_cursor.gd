extends Node2D

func _process(delta: float) -> void:
    if TurretBuilder.turret_index == -1 :
        visible = false
        return
        
    visible = true
        
    global_position = get_global_mouse_position().snapped(Vector2(128, 128)) 
    $Sprite2D.texture.current_frame = TurretBuilder.turret_index
    
    if GridOrganizer.is_in_used_grid(global_position) or GlobalStats.player_money < TurretBuilder.prices[TurretBuilder.turret_index] :
        modulate = Color(0.67, 0, 0, 0.5)
    else :
        modulate = Color(0, 0.67, 0, 0.5)
