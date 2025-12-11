extends PointLight2D

var target_energy = 1.0

func _process(delta):
	if randf() > 0.9:
		target_energy = randf_range(0.4, 1.2)
	energy = lerp(energy, target_energy, delta * 10)
