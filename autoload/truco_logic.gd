extends Node


const CARD_ORDER = [4, 5, 6, 7, 12, 11, 13, 1, 2, 3]
const SUIT_ORDER = [Card.Suit.DIAMONDS, Card.Suit.SPADES, Card.Suit.HEARTS, Card.Suit.CLUBS]


func card_compare(lhs: Card, rhs: Card, vira: Card) -> int:
	if rhs.flipped and not lhs.flipped:
		return -1
	if lhs.flipped and not rhs.flipped:
		return 1
	if lhs.flipped and rhs.flipped:
		return 0

	var lhs_value := CARD_ORDER.find(lhs.number)
	var rhs_value := CARD_ORDER.find(rhs.number)

	var manilha := wrapi(CARD_ORDER.find(vira.number) + 1, 0, CARD_ORDER.size())

	var lhs_manilha := lhs_value == manilha
	var rhs_manilha := rhs_value == manilha

	if lhs_manilha and not rhs_manilha:
		return -1
	if rhs_manilha and not lhs_manilha:
		return 1
	if rhs_manilha and lhs_manilha:
		var lhs_suit_value := SUIT_ORDER.find(lhs.suit)
		var rhs_suit_value := SUIT_ORDER.find(rhs.suit)
		return signi(rhs_suit_value - lhs_suit_value)

	return signi(rhs_value - lhs_value)


func resolve_winner(cards: Array[Card], vira: Card) -> Array[Card]:
	var ret: Array[Card] = []

	var wins := [0, 0, 0, 0]
	for i in range(cards.size() - 1):
		for j in range(i + 1, cards.size()):
			var cmp := card_compare(cards[i], cards[j], vira)
			wins[i] -= cmp
			wins[j] += cmp

	return ret
