extends Node2D

var enemy_pos: Vector2
var scan_bug_time := 0.0
var weapon_cd_time := 0.0
var MAX_DIST = 128 * 5
var weapons:Array[Node]
var weapons_index:int

@export var cycle_delay := 1.0 #delay between each cycle
@export var weapons_delay := 0.0 #delay between each cycle
var total_time_delayed := 0.0

#func _input(evt) -> void:
    #if evt is InputEventMouseButton :
        #if evt.pressed and evt.button_index == MOUSE_BUTTON_RIGHT :
            #enemy_pos = evt.position
    
var target_bug:Node

func _ready() -> void:
    target_bug = find_nearest_bug()
    
    # get all weapons
    for child in get_children() :
        if "Weapon" in child.name :
            weapons.append(child)
    
    
func _process(delta) -> void:
    if not Brain.game_running :
        return
        
    scan_bug_time += delta
    
    if scan_bug_time > 1 :
        scan_bug_time = 0
        target_bug = find_nearest_bug()
        
    if target_bug == null and not get_parent().main_menu_mode:
        return
        #for child in get_children() :
                #if not "Weapon" in child.name :
                    #return
                #child.shooting = false
    
    if get_parent().main_menu_mode :
        enemy_pos = get_global_mouse_position()
    else :
        enemy_pos = target_bug.global_position
        
    var theta := atan2( (enemy_pos.y - global_position.y), (enemy_pos.x - global_position.x) )
    rotation = theta
    
    if weapons_index == len(weapons) :
        if total_time_delayed > cycle_delay :
            weapons_index = 0
            total_time_delayed = 0
        else :
            total_time_delayed += delta     
            return   
        
    weapon_cd_time += delta
    if weapon_cd_time > weapons_delay :
        weapon_cd_time = 0
        weapons[weapons_index].shoot()
        
        weapons_index = (weapons_index + 1) #% len(weapons)
        
    
            
            
    
    
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
        
