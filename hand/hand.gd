class_name Hand
extends Node2D


@export var width := 250.0


func get_cards() -> Array[Card]:
	var cards: Array[Card]
	cards.assign(get_children())
	return cards


func add_card(card: Card) -> void:
	Utils.unparent_node(card)
	add_child(card)
	card.mouse_entered.connect(_on_card_mouse_entered.bind(card))
	card.mouse_exited.connect(_on_card_mouse_exited.bind(card))
	_update_cards_position()


func remove_card(card: Card) -> void:
	Utils.unparent_node(card)
	card.mouse_entered.disconnect(_on_card_mouse_entered.bind(card))
	card.mouse_exited.disconnect(_on_card_mouse_exited.bind(card))
	card.highlighted = false
	_update_cards_position()


func _update_cards_position() -> void:
	var cards := get_children()
	var cards_count := cards.size()
	var spacing := width / (cards_count + 1)
	for i in range(1, cards_count + 1):
		cards[i - 1].position = Vector2.LEFT * ((spacing * i) - (width / 2))


func _on_card_mouse_entered(card: Card) -> void:
	card.highlighted = true


func _on_card_mouse_exited(card: Card) -> void:
	card.highlighted = false
