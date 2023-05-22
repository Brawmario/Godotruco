class_name Card
extends Area2D


enum Suit {
	HEARTS,
	DIAMONDS,
	CLUBS,
	SPADES,
}

signal mouse_clicked()

@export var number := 1:
	set(value):
		number = value
		_update_sprite()
@export var suit := Suit.HEARTS:
	set(value):
		suit = value
		_update_sprite()
@export var flipped := true:
	set(value):
		flipped = value
		_update_sprite()
@export var highlighted := false:
	set(value):
		highlighted = value
		_update_sprite()

var from_player := -1

@onready var _sprite_2d: Sprite2D = $Sprite2D


func _update_sprite() -> void:
	if not _sprite_2d:
		await ready
	if flipped:
		_sprite_2d.frame_coords = Vector2(13, 1)
	else:
		_sprite_2d.frame_coords = Vector2(number - 1 , suit)
	_sprite_2d.scale = Vector2.ONE * (1.8 if highlighted else 1.5)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var event_mouse := event as InputEventMouseButton
	if event_mouse and event_mouse.button_index == MOUSE_BUTTON_LEFT and event_mouse.pressed:
		mouse_clicked.emit()
