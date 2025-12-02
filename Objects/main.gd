extends Node2D

func _input(evt) -> void:
    #if evt is InputEventMouseButton :
        #if evt.pressed and evt.button_index == MOUSE_BUTTON_LEFT :
            ##print(evt.position);
    ## get physics space from      the world     (this is the physics space)
            #var physics_space = get_world_2d().direct_space_state
            #
            ## create a query for the ray direction using this weird ass object
            #var query := PhysicsRayQueryParameters2D.create(evt.position, evt.position + Vector2(100, 0))
            ## cast the rays
            #var result: Dictionary = physics_space.intersect_ray(query)
            #
            #pretty_print(result)
            
    # quick quit for debugging
    if evt is InputEventKey :
        if evt.pressed and evt.keycode == KEY_ESCAPE :
            if not Brain.game_running :
                return
            Brain.game_running = false
            $Control/PauseMenu.visible = true
            #get_tree().quit()


func pretty_print(dict: Dictionary) -> void :
    
    for key in dict :
        print(key, ": ", dict[key]);
    
