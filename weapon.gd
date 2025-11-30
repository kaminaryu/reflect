extends Node2D

@export var delay: float
@export var delay_offset: float

@onready var bulletScn := preload("res://Objects/Components/bullet.tscn")

var totalTime:float = 0.0
var shooting := false # for head.gd

func _ready() -> void:
    visible = false
    
func _process(delta: float) -> void:
    #if not shooting :
        #totalTime = delay #for head.gd
        #return
        
    if get_parent().target_bug == null :
        #totalTime = delay # so that the turret will immedietly shoot on sight
        return
        
    totalTime += delta

    if totalTime > delay :
        totalTime = 0.0
        
        var bullet := bulletScn.instantiate()
        get_tree().current_scene.add_child(bullet)
        
        bullet.global_position = global_position
        bullet.direction = Vector2.RIGHT.rotated(get_parent().rotation)
    
        #print("New bullet spawned"); print(get_parent().rotation)
        #print(global_position, bullet.global_position)
        
        
