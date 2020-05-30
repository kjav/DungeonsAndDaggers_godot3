extends Node
static func getNextTargetPos(pos, direction):
	match direction:
		Enums.DIRECTION.UP:
			pos.y -= 1
		Enums.DIRECTION.DOWN:
			pos.y += 1
		Enums.DIRECTION.LEFT:
			pos.x -= 1
		Enums.DIRECTION.RIGHT:
			pos.x += 1
	
	return pos

static func absoluteAttackPositions(targetPos, additionalRelativeAttackPositions, direction):
	var additional = additionalAbosoluteAttackPositions(targetPos, additionalRelativeAttackPositions, direction)
	return([targetPos] + additional)

static func additionalAbosoluteAttackPositions(targetPos, additionalRelativeAttackPositions, direction):
	if (additionalRelativeAttackPositions.size() > 0):
		return convertRelativePositionToAbsolute(targetPos, additionalRelativeAttackPositions, direction)
	
	return []

static func convertRelativePositionToAbsolute(currentPosition, relativePositions, direction):
	var phi
	
	match direction:
		Enums.DIRECTION.UP:
			phi = 0
		Enums.DIRECTION.DOWN:
			phi = PI
		Enums.DIRECTION.LEFT:
			phi = (3 *  PI) / 2
		Enums.DIRECTION.RIGHT:
			phi = PI /2
		Enums.DIRECTION.NONE:
			return []
	
	var AbsolutePositions = []

	for relativePosition in relativePositions:
		var rotated = relativePosition.rotated(phi)
		AbsolutePositions.push_back(roundVector2(rotated) + currentPosition)
	
	return AbsolutePositions

static func roundVector2(pos):
	return Vector2(round(pos.x), round(pos.y))

static func getRelativeCoordinatesAroundPoint(distance):
	var pointsForDistance = []
	var x = -distance
	var y = -distance
	
	while (x <= distance):
		while (y <= distance):
			if (x != 0 or y != 0):
				pointsForDistance.push_back(Vector2(x, y)) 
			y += 1
		y = -distance
		x += 1
	
	return pointsForDistance
