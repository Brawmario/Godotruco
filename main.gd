extends Node2D


var _vira: Card = null
var _current_player: int
var _played_cards_count := 0
var _player_order := [1, 2, 3, 4]
var _winning_cards: Array[Card] = []

@onready var _deck: Deck = $Deck
@onready var _vira_container: Marker2D = $ViraContainer
@onready var _hand_to_container := {
	$"Hands/1": $PlayedCards/CardContainer1,
	$"Hands/2": $PlayedCards/CardContainer2,
	$"Hands/3": $PlayedCards/CardContainer3,
	$"Hands/4": $PlayedCards/CardContainer4,
}


func _ready() -> void:
	_fill_hands()
	_draw_vira()


func _fill_hands() -> void:
	for player in range(1, 5):
		var hand := get_node("Hands/" + str(player)) as Hand
		for _i in range(3):
			var card = _deck.draw_card()
			card.flipped = false
			hand.add_card(card)
		hand.card_picked.connect(_play_card_from_player.bind(hand))


func _draw_vira() -> void:
	_vira = _deck.draw_card()
	_vira.flipped = false
	_vira_container.add_child(_vira)


func _play_card_from_player(card: Card, hand: Hand) -> void:
	var card_container: Node2D = _hand_to_container.get(hand)

	card.flipped = false

	var card_global_position := card.global_position
	hand.remove_card(card)
	card_container.add_child(card)
	card.global_position = card_global_position

	var tween := create_tween()
	tween.tween_property(card, "position", Vector2.ZERO, 0.1)
	await tween.finished

	_update_winning_cards(card)

	_played_cards_count += 1
	if _played_cards_count >= 4:
		_resolve_turn()


func _update_winning_cards(played_card: Card) -> void:
	if _winning_cards.is_empty():
		_winning_cards.append(played_card)
		return

	var cmp = TrucoLogic.card_compare(_winning_cards[0], played_card, _vira)
	match cmp:
		-1:
			pass
		0:
			_winning_cards.append(played_card)
		1:
			_winning_cards.clear()
			_winning_cards.append(played_card)


func _resolve_turn() -> void:
	var winning_players := _winning_cards.map(func(card): return card.from_player)

	if (winning_players.has(1) or winning_players.has(3)) and (winning_players.has(2) or winning_players.has(4)):
		print("round winner: Tie!")
	else:
		print("round winner: player ", winning_players[0])

	_winning_cards.clear()
	_played_cards_count = 0
