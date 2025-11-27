extends Node2D

@onready var arch_scn = preload("res://Objects/Turrets/arch.tscn")

func _input(evt: InputEvent) -> void :
    if evt is InputEventMouseButton :
        if evt.pressed and evt.button_index == MOUSE_BUTTON_MIDDLE :
            var arch = arch_scn.instantiate()
            arch.position = get_global_mouse_position()
            get_tree().current_scene.add_child(arch)

            
    
