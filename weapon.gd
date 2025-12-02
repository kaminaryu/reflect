extends Node2D

@export var delay: float
@export var bullet_scale := 1.0
@export var bullet_dmg := 1.0
@export var piercing := 0

@onready var bulletScn := preload("res://Objects/Components/bullet.tscn")

var totalTime:float = 0.0
var shooting := false # for head.gd

func _ready() -> void:
    visible = false
    
#func _process(delta: float) -> void:
    ##if not shooting :
        ##totalTime = delay #for head.gd
        ##return
        #
    #if get_parent().target_bug == null :
        ##totalTime = delay # so that the turret will immedietly shoot on sight
        #return
        #
    #totalTime += delta
#
    #if totalTime > delay :
        #totalTime = 0.0
        ##await get_tree().create_timer(delay_offset).timeout
        #
        ##shoot()

func shoot() -> void :
    if not Brain.game_running :
        return
        
    if get_parent().target_bug == null : 
        return
        
    var bullet := bulletScn.instantiate()
    get_tree().current_scene.add_child(bullet)
    #bullet.add_to_group("Objects")
    
    var enemy_pos:Vector2 = get_parent().target_bug.global_position
    #var enemy_pos = get_global_mouse_position()
    var theta := atan2( (enemy_pos.y - global_position.y), (enemy_pos.x - global_position.x) )
    var bullet_rot := theta
    
    bullet.global_position = global_position
    bullet.direction = Vector2.RIGHT.rotated(bullet_rot)
    bullet.scale = Vector2(bullet_scale, bullet_scale)
    bullet.damage = bullet_dmg
    bullet.piercing_left = piercing
    
    $AudioStreamPlayer2D.play()
    
    
    #print("New bullet spawned"); print(get_parent().rotation)
    #print(global_position, bullet.global_position)
        
        
