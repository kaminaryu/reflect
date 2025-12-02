extends Label

func _process(delta: float) -> void:
    text = str(GlobalStats.player_money)
