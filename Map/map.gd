extends Node2D

const MAP_SIZE := Vector2(10, 6)

@onready var black_scn := preload("res://Map/black_square.tscn")
@onready var tileMap := $TileMapLayer
var gen_path:Dictionary # store all path

func rand_vector(from: Vector2, to: Vector2) -> Vector2:
    var v: Vector2
    v.x = randi_range(from.x, to.x)
    v.y = randi_range(from.y, to.y)
    return v
    
func add_path(coords:Vector2, atlas_pos:Vector2, dir:int, turn_to:float = 0) -> void :
    tileMap.set_cell(coords, 0, atlas_pos, dir)
    var pos:Vector2 = tileMap.map_to_local(coords) + tileMap.position
    gen_path[coords] = {
        "dir": dir,
        # translate map to viewport pos + offset
        "pos": pos,
        "turn_to": turn_to
    }
    
    # add to grid organizer so that i can check for used tiles esp at Turret_Cursor.tscn
    GridOrganizer.add_to_grid(pos)
    
    
    # add black square for fog of war of paths
    var black := black_scn.instantiate()
    black.position = tileMap.map_to_local(coords) + tileMap.position
    add_child(black) 
    
func out_of_bounds(pos:Vector2, bounds:Vector2) -> bool :
    return pos.x > bounds.x or pos.x < 0 \
    or pos.y > bounds.y or pos.y < 0
    
func round_vector(v:Vector2) -> Vector2 :
    v.x = round(v.x)
    v.y = round(v.y)
    return v

    
func generate_paths() -> int :
    #print("------------------------")
    
    # centering the map
    # gonna be honest, idk why i need to + Vector2(1, 1)
    var mapSize := (MAP_SIZE + Vector2(1, 1)) * 128
    var vp_size = get_viewport().get_visible_rect().size * 2 #because zoomed out
    tileMap.position = ((vp_size - mapSize) * 0.5).snapped(Vector2(128, 128)) + Vector2(64, 64) # offset cuz fucky wucky
    
    
    # generate start point
    var path_pos := rand_vector(Vector2.ZERO, Vector2(MAP_SIZE.x/2, MAP_SIZE.y))
    var path_dir := Vector2.RIGHT
    var cardinal_dir := 1 # for tiles atlas, N = 0, E = 1, S = 2, W = 3, going left is +1, going right is +0
    var goal_pos := path_pos
    var end_pos  := path_pos
    add_path(goal_pos, Vector2(1,1), cardinal_dir)
    #print("Start goal ", path_pos, " | ", cardinal_dir)
    
    # get path length, part of map size +- offsets
    var offset := randi_range(-4, 4)
    var path_len:int = 0.25 * (MAP_SIZE.x * MAP_SIZE.y) + offset
    #print(path_len)
    
    # generate path (straights or turn)
    for i in range(path_len) :
        path_pos = round_vector(path_pos + path_dir)
        
        # predicted path, for checking
        var pred_path:Dictionary = {
            "right": round_vector(path_pos + path_dir.rotated(PI/2)),
            "left": round_vector(path_pos + path_dir.rotated(-PI/2)),
            "straight": round_vector(path_pos + path_dir)
        }
        var right_blocked := false
        var left_blocked := false
        var straight_blocked := false
        
        # check if path is blocked
        if pred_path.right in gen_path or out_of_bounds(pred_path.right, MAP_SIZE) :
            right_blocked = true
            
        if pred_path.left in gen_path or out_of_bounds(pred_path.left, MAP_SIZE) :
            left_blocked = true
            
        if pred_path.straight in gen_path or out_of_bounds(pred_path.straight, MAP_SIZE) :
            straight_blocked = true
            
        # restart if all path is blocked lol
        if right_blocked and left_blocked and straight_blocked :
            return -1
            
        #print("Path exists: ", path_pos in gen_path, " => ", right_blocked, " | ", left_blocked, " | ", straight_blocked)
        #print("Current Path: ", path_pos, " | ", cardinal_dir, " | ", path_dir)
            
        # if its the last cell, we add the end goal
        if i == path_len - 1 :
            end_pos = path_pos
            add_path(end_pos, Vector2(1, 1), cardinal_dir +  4)
            #print("End goal: ", path_pos, " | ", cardinal_dir, " | ", path_dir)
            break
             
        # if 70% or both sides path are blocked || force turn if straight path is blocked 
        if (randi_range(0, 10) > 3 or (right_blocked and left_blocked)) and not straight_blocked :
            add_path(path_pos, Vector2(0, 0), cardinal_dir % 2)
            #print("going straight")
            
        # turn
        else :
            # right and not blocked and if left is free, force turn right
            if (randi_range(0, 1) and not right_blocked) or left_blocked:
                add_path(path_pos, Vector2(1, 0), cardinal_dir, PI/2)
                path_dir = path_dir.rotated(PI/2)
                cardinal_dir += 1
                #print("turning righ")
            
            # left
            else :
                add_path(path_pos, Vector2(1, 0), (cardinal_dir + 1) % 4, -PI/2)
                path_dir = path_dir.rotated(-PI/2)
                cardinal_dir -= 1
                #print("turning left")
            
            # because -1 % 4 != apparently
            if cardinal_dir == -1 :
                cardinal_dir = 3
                
            cardinal_dir %= 4
        #print("")
    
    


    $BugSpawner.init_spawner(goal_pos, end_pos, gen_path)
    #print("what")
    return 0
    
    
func _ready() -> void:
    while true :
        tileMap.clear()
        gen_path.clear()
        GridOrganizer.used_grids.clear()
        
        # borders
        #tileMap.set_cell(Vector2i(0, 0), 0, Vector2i(0, 0), 1)
        #tileMap.set_cell(Vector2i(MAP_SIZE.x, 0), 0, Vector2i(0, 0), 1)
        #tileMap.set_cell(Vector2i(0, MAP_SIZE.y), 0, Vector2i(0, 0), 1)
        #tileMap.set_cell(MAP_SIZE, 0, Vector2i(0, 0), 1)
        
        # repeatly gen path until valid path is created
        var err = generate_paths()
        
        if not err :
            break

    
# re generate paths
#func _input(event: InputEvent) -> void:
    #if event is InputEventMouseButton :
        #if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT :
            #while true :
                #tileMap.clear()
                #gen_path.clear()
                #var err = generate_paths()
                #
                #if not err :
                    #break
