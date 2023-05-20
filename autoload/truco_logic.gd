extends Node


const CARD_ORDER = [4, 5, 6, 7, 12, 11, 13, 1, 2, 3]
const SUIT_ORDER = [Card.Suit.DIAMONDS, Card.Suit.SPADES, Card.Suit.HEARTS, Card.Suit.CLUBS]


func resolve_winner(lhs: Card, rhs: Card, vira: Card) -> int:
	var lhs_value := -1 if lhs.flipped else CARD_ORDER.find(lhs.number)
	var rhs_value := -1 if rhs.flipped else CARD_ORDER.find(rhs.number)

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
