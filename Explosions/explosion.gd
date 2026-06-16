@tool
class_name Explosion extends Node2D

@export var _emitting := false:
	set(val):
		_emitting = val
		_no_particles_emitting = _particles.all(func(p: CPUParticles2D): return not p.emitting)
		if _no_particles_emitting:
			for p in _particles:
				p.emitting = val

@onready var _particles: Array[CPUParticles2D] = []

var _no_particles_emitting: bool

func _ready() -> void:
	_particles.assign(find_children("*", "CPUParticles2D"))
	if not Engine.is_editor_hint():
		_emitting = true
		_no_particles_emitting = false
		for p in _particles:
			p.emitting = true
			p.finished.connect(_on_particles_finished)
	else:
		_no_particles_emitting = true
		for p in _particles:
			p.finished.connect(_on_particles_finished)

func _on_particles_finished() -> void:
	_no_particles_emitting = _particles.all(func(p: CPUParticles2D): return not p.emitting)
	if _no_particles_emitting:
		_emitting = false
		if not Engine.is_editor_hint():
			queue_free()
