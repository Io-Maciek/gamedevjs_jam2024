extends Area3D

@onready var player: PlayerMovement = $".."
@onready var audio_water_plum:AudioStreamPlayer = $AudioStreamWaterPlum


var inside_of_water:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	if !area:
		return
	if area.name == "Water":
		inside_of_water+=1
		if inside_of_water == 1:
			if player.velocity.y < -0.2:
				var clamped = clamp(player.velocity.y, -10, 0)
				var audio_volume_remap = remap(clamped,0,-10, 0, 1)
				var audio_volume_to_db = log(audio_volume_remap) * 8.6858896380650365530225783783321
				var c = clamp(audio_volume_to_db, -20, 0)
				
				audio_water_plum.volume_db = c
				audio_water_plum.playing = true
			player.SHOULD_CROUCH_ABILITY = false
			if player.is_crouched:
				player.CrouchEnd()
			#print("JEST"+str(inside_of_water))
			player.is_in_water = true
	


func _on_area_exited(area):
	if !area:
		return
	if area.name == "Water":
		inside_of_water-=1
		if inside_of_water<=0:
			player.SHOULD_CROUCH_ABILITY = true
			#print("pa...")
			player.is_in_water = false
