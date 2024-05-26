class_name WeaponInHand extends Area3D

signal broken(sender: WeaponInHand)

@export var is_default : bool = false
@export var durability : int = 1
@export var damage     : int = 1

func check_broken():
	if is_default: return
	
	durability -= 1
	if durability <= 0:
		broken.emit(self)
