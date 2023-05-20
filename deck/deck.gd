class_name Deck
extends Node2D


const CardScene = preload("res://card/card.tscn")

@export var truco_deck := false

var _stack: Array[Vector2i]


func _ready() -> void:
	new_stack()


func new_stack() -> void:
	_stack.clear()

	if truco_deck:
		for suit in range(1, 4):
			for number in range(1, 8):
				_stack.append(Vector2i(number, suit))
			for number in range(11, 14):
				_stack.append(Vector2i(number, suit))
	else:
		for suit in range(1, 4):
			for number in range(1, 14):
				_stack.append(Vector2i(number, suit))

	_stack.shuffle()


func shuffle() -> void:
	_stack.shuffle()


func draw_card() -> Card:
	return _vector2i_to_card(_stack.pop_front())


func _vector2i_to_card(value: Vector2i) -> Card:
	var card: Card = CardScene.instantiate()
	card.number = value.x
	card.suit = value.y
	return card
