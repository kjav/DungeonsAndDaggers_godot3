class StraightTransition extends Node:
	func getNewState(pos, original_pos, movement_direction, moving, delta):
		var returnedPos
		var returnedMoving = moving
		if moving:
			if movement_direction != Enums.DIRECTION.NONE:
				returnedPos = getPositionAfterMove(movement_direction, pos, delta)
				if returnedPos != null && movedPastTileWidth(returnedPos, original_pos):
					var state = snapMoveBackToTileSize(movement_direction, original_pos)
					if state[0] != null:
						returnedPos = state[0]
					if state[1] != null:
						returnedMoving = state[1]
			else:
				returnedPos = original_pos
				returnedMoving = false
		return([returnedPos, returnedMoving])
	
	func movedPastTileWidth(returnedPos, original_pos):
		return returnedPos.distance_to(original_pos) >= GameData.TileSize
	
	func getPositionAfterMove(movement_direction, pos, delta):
		var returnedPos
		if movement_direction == Enums.DIRECTION.LEFT:
			returnedPos = (pos + Vector2(-GameData.TileSize * (delta / 0.4), 0))
		elif movement_direction == Enums.DIRECTION.RIGHT:
			returnedPos = (pos + Vector2(GameData.TileSize * (delta / 0.4), 0))
		elif movement_direction == Enums.DIRECTION.UP:
			returnedPos = (pos + Vector2(0, -GameData.TileSize * (delta / 0.4)))
		elif movement_direction == Enums.DIRECTION.DOWN:
			returnedPos = (pos + Vector2(0, GameData.TileSize * (delta / 0.4)))
		return returnedPos
	
	func snapMoveBackToTileSize(movement_direction, original_pos):
		var returnedPos

		if movement_direction == Enums.DIRECTION.LEFT:
			returnedPos = (original_pos + Vector2(-GameData.TileSize, 0))
		elif movement_direction == Enums.DIRECTION.RIGHT:
			returnedPos = (original_pos + Vector2(GameData.TileSize, 0))

		if movement_direction == Enums.DIRECTION.UP:
			returnedPos = (original_pos + Vector2(0, -GameData.TileSize))
		elif movement_direction == Enums.DIRECTION.DOWN:
			returnedPos = (original_pos + Vector2(0, GameData.TileSize))

		return ([returnedPos, false])
