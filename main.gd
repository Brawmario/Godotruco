extends Node2D


var _vira: Card

@onready var _deck: Deck = $Deck
@onready var _vira_container: Marker2D = $ViraContainer


func _ready() -> void:
	_fill_hands()
	_draw_vira()


func _fill_hands() -> void:
	for player in range(1, 5):
		for _i in range(3):
			var hand := get_node("Hands/" + str(player)) as Hand
			var card = _deck.draw_card()
			card.flipped = false
			hand.add_card(card)


func _draw_vira() -> void:
	_vira = _deck.draw_card()
	_vira.flipped = false
	_vira_container.add_child(_vira)
