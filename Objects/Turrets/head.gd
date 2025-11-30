extends Node2D

var enemy_pos: Vector2
var total_time := 0.0
var MAX_DIST = 128 * 5

#func _input(evt) -> void:
    #if evt is InputEventMouseButton :
        #if evt.pressed and evt.button_index == MOUSE_BUTTON_RIGHT :
            #enemy_pos = evt.position
    
var target_bug:Node

func _ready() -> void:
    target_bug = find_nearest_bug()
    
    
func _process(delta) -> void:
    total_time += delta
    
    if total_time > 1 :
        total_time = 0
        target_bug = find_nearest_bug()
        
    if target_bug == null :
        #for child in get_children() :
                #if not "Weapon" in child.name :
                    #return
                #child.shooting = false
        return
        
    enemy_pos = target_bug.global_position
    #enemy_pos = get_global_mouse_position()
    var theta := atan2( (enemy_pos.y - global_position.y), (enemy_pos.x - global_position.x) )
    rotation = theta
    
    
    
func find_nearest_bug() -> Node :  
    var bugs = get_tree().get_nodes_in_group("Bugs")
    var min_dist := 100000.0
    var target_bug:Node = null
    
    for bug in bugs :
        var curr_dist := global_position.distance_to(bug.position) 
        
        if curr_dist < min_dist and curr_dist < MAX_DIST :
            min_dist = curr_dist
            target_bug = bug
            #for child in get_children() :
                #if not "Weapon" in child.name :
                    #return
                #child.shooting = true
    
    return target_bug
        
