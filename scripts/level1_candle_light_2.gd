extends PointLight2D

var target_energy = 1.0

func _process(delta):
	# Randomly change target energy slightly
	if randf() > 0.9:
		target_energy = randf_range(0.4, 1.2)
	
	# Smoothly interpolate to the new energy
	energy = lerp(energy, target_energy, delta * 10)
