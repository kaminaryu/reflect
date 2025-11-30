# ts an singleton / autoload
extends Node2D

@onready var arch_scn = preload("res://Objects/Turrets/twin.tscn")

func _input(evt: InputEvent) -> void :
    if evt is InputEventMouseButton :
        if evt.pressed and evt.button_index == MOUSE_BUTTON_MIDDLE :
            var mouse_pos = get_global_mouse_position().snapped(Vector2(128, 128))
            
            if GridOrganizer.is_in_used_grid(mouse_pos) :
                return
                
            var arch = arch_scn.instantiate()
            arch.position = mouse_pos
            get_tree().current_scene.add_child(arch)
            GridOrganizer.add_to_grid(mouse_pos)
            
            
            
            

            
    
