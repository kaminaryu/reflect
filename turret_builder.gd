# ts an singleton / autoload
extends Node2D

var selected_turret_scn

@onready var arch_scn = preload("res://Objects/Turrets/arch.tscn")
@onready var twin_scn = preload("res://Objects/Turrets/twin.tscn")

func _input(evt: InputEvent) -> void :
    #if evt is InputEventMouseButton :
        #if evt.pressed and evt.button_index == MOUSE_BUTTON_MIDDLE :
    if evt is InputEventKey :
        if evt.pressed :
            if evt.keycode == KEY_1 :
                selected_turret_scn = arch_scn
            elif evt.keycode == KEY_2 :
                selected_turret_scn = twin_scn
                
            
            var mouse_pos = get_global_mouse_position().snapped(Vector2(128, 128))
            
            if GridOrganizer.is_in_used_grid(mouse_pos) :
                return
                
            var turret = selected_turret_scn.instantiate()
            turret.scale = Vector2(0.75, 0.75)
            turret.position = mouse_pos
            get_tree().current_scene.add_child(turret)
            GridOrganizer.add_to_grid(mouse_pos)
            
            
            
            

            
    
