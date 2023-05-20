class_name Utils
extends Object


static func unparent_node(node: Node) -> void:
	var parent := node.get_parent()
	if parent:
		parent.remove_child(node)
