extends Node

var volume: float = 1.0:
	set(value):
		volume = clamp(value, 0.0, 1.0)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume))
