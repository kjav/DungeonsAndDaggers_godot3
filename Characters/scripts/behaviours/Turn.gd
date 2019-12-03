class BaseTurn:
	var character
	
	func _init(_character = null):
		character = _character
	
	func turn(pos):
		pass
	
	func afterMoveComplete(pos):
		pass

class Wait extends BaseTurn:
	func _init(_character = null).(_character):
		pass
	
	func turn(pos):
		return Enums.DIRECTION.NONE

class MoveTo extends BaseTurn:
	func _init(_character = null).(_character):
		pass
	
	func turn(pos):
		pos.x = int(pos.x / GameData.TileSize)
		pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.turn_end_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		return GameData.tilemap.findNextDirection(pos, player_pos)
	
	func getPathFindingDistance(pos):
		var divided_pos = Vector2(0,0)
		divided_pos.x = int(pos.x / GameData.TileSize)
		divided_pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.turn_end_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		return GameData.tilemap.findPathDistance(divided_pos, player_pos)

class MoveRandom extends BaseTurn:
	func _init(_character = null).(_character):
		pass
	
	func turn(pos):
		return randi()%5

class MoveUpRightDownLeft extends BaseTurn:
	var count = 0
	
	func _init(_character = null).(_character):
		pass
	
	func turn(pos):
		count += 1
		var currentMove = count%4
		
		if currentMove == 0:
			return Enums.DIRECTION.UP
		elif currentMove == 1:
			return Enums.DIRECTION.RIGHT
		elif currentMove == 2:
			return Enums.DIRECTION.DOWN
		elif currentMove == 3:
			return Enums.DIRECTION.LEFT

class MoveUpLeftDownRight extends BaseTurn:
	var count = 0
	
	func _init(_character = null).(_character):
		pass
	
	func turn(pos):
		count += 1
		var currentMove = count%4
		
		if currentMove == 0:
			return Enums.DIRECTION.UP
		elif currentMove == 1:
			return Enums.DIRECTION.LEFT
		elif currentMove == 2:
			return Enums.DIRECTION.DOWN
		elif currentMove == 3:
			return Enums.DIRECTION.RIGHT

class MoveToSignalBeforeAttackRecoverIfMissed extends BaseTurn:
	var moveTo
	var waitAttackWaitCount = -1
	var attackDirection
	var shouldStun = false
	var additionalRelativeAttackPositions = []
	
	func _init(_character = null).(_character):
		moveTo = MoveTo.new(_character)
	
	func turn(pos):
		if GameData.player.alive():
			var divided_pos = Vector2(0,0)
			divided_pos.x = int(pos.x / GameData.TileSize)
			divided_pos.y = int(pos.y / GameData.TileSize)
			var player_pos = GameData.player.turn_end_pos
			player_pos.x = int(player_pos.x / GameData.TileSize)
			player_pos.y = int(player_pos.y / GameData.TileSize)
			
			if inWaitAttackWaitSequence():
				waitAttackWaitCount += 1
				
				if Attacking():
					if playerInAttackablePosition(player_pos, divided_pos, additionalRelativeAttackPositions):
						return moveTo.turn(pos)
					
					shouldStun = randi()%2 == 1
				else:
					LeaveWaitAttackWaitSequence()
					return turn(pos)
			elif !GameData.player.invisible && divided_pos.distance_squared_to(player_pos) > 1:
				return moveTo.turn(pos)
		
		return Enums.DIRECTION.NONE
	
	func playerInAttackablePosition(player_pos, divided_pos, additionalRelativeAttackPositions):
		var absolutePositions = PositionHelper.absoluteAttackPositions(PositionHelper.getNextTargetPos(divided_pos, attackDirection), additionalRelativeAttackPositions, attackDirection)
		
		for absolutePosition in absolutePositions:
			if (absolutePosition.x == player_pos.x and absolutePosition.y == player_pos.y):
				return true
		
		return false
	
	func PreparingAttack():
		return waitAttackWaitCount == 0
		
	func Attacking():
		return waitAttackWaitCount == 1
	
	func inWaitAttackWaitSequence():
		return waitAttackWaitCount >= 0
	
	func LeaveWaitAttackWaitSequence():
		waitAttackWaitCount = -1
	
	func addStun():
		LeaveWaitAttackWaitSequence()
		shouldStun = false
		
		character.addStun(max(randi() % 5 - 1, 2))
	
	func afterMoveComplete(pos):
		if (shouldStun):
			addStun()
		
		if (character.stunnedDuration > 0):
			return
		
		var divided_pos = Vector2(0,0)
		divided_pos.x = int(pos.x / GameData.TileSize)
		divided_pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.turn_end_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		
		if !inWaitAttackWaitSequence() and divided_pos.distance_squared_to(player_pos) <= 1:
			waitAttackWaitCount = 0
			attackDirection = moveTo.turn(pos)

class InRangeMoveToOtherwiseRandom extends BaseTurn:
	var random
	var moveTo
	var limit = 10
	
	func _init(_character = null).(_character):
		random = MoveRandom.new(_character)
		moveTo = MoveTo.new(_character)
	
	func setLimit(newLimit):
		limit = newLimit

	func turn(pos):
		var divided_pos = Vector2(0,0)
		divided_pos.x = int(pos.x / GameData.TileSize)
		divided_pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.turn_end_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		if GameData.player.alive() and !GameData.player.invisible and moveTo.getPathFindingDistance(pos) < limit:
			# Select movement direction towards player
			return moveTo.turn(pos)
		else:
			# Select random movement direction
			return random.turn(pos)

class BehaviourEveryN extends BaseTurn:
	var behaviour 
	var turnWait = 2
	var counter = 0
	
	func _init(_character = null).(_character):
		pass
	
	func setTurnWait(newTurnWait):
		turnWait = newTurnWait
	
	func setBehaviour(newBehaviour):
		behaviour = newBehaviour
	
	func turn(pos):
		counter += 1
		if (counter % (turnWait+1) == 0):
			return behaviour.turn(pos)
		else:
			return Enums.DIRECTION.NONE

class InRangeMoveToOtherwiseRandomEveryNTurns extends BaseTurn:
	var turnBehaviour
	var behaviourEveryN
	var turnWait = 2
	var limit = 10
	
	func _init(_character = null).(_character):
		turnBehaviour = InRangeMoveToOtherwiseRandom.new(_character)
		behaviourEveryN = BehaviourEveryN.new(_character)
	
		behaviourEveryN.setBehaviour(turnBehaviour)
		behaviourEveryN.setTurnWait(turnWait)
	
	func setTurnWait(newTurnWait):
		turnWait = newTurnWait
		behaviourEveryN.setTurnWait(turnWait)
		
	func setLimit(newLimit):
		limit = newLimit
		turnBehaviour.setLimit(limit)
	
	func turn(pos):
		return behaviourEveryN.turn(pos)
		

class BehaviourEveryNInvinsibleOnWait extends BaseTurn:
	var behaviour 
	var turnWait = 2
	var counter = 0
	var damageable = true
	
	func _init(_character = null).(_character):
		pass
	
	func setTurnWait(newTurnWait):
		turnWait = newTurnWait
	
	func setBehaviour(newBehaviour):
		behaviour = newBehaviour
	
	func turn(pos):
		counter += 1
		if (counter % (turnWait+1) == 0):
			damageable = true
			return behaviour.turn(pos)
		else:
			damageable = false
			return Enums.DIRECTION.NONE
	
	func getDamageable():
		return damageable

class InRangeMoveToOtherwiseRandomEveryNTurnsInvinsibleOnWait extends BaseTurn:
	var turnBehaviour
	var behaviourEveryNInvinsibleOnWait
	var turnWait = 2
	var limit = 10
	
	func _init(_character = null).(_character):
		turnBehaviour = InRangeMoveToOtherwiseRandom.new(_character)
		behaviourEveryNInvinsibleOnWait = BehaviourEveryNInvinsibleOnWait.new(_character)
		
		behaviourEveryNInvinsibleOnWait.setBehaviour(turnBehaviour)
		behaviourEveryNInvinsibleOnWait.setTurnWait(turnWait)
	
	func setTurnWait(newTurnWait):
		turnWait = newTurnWait
		behaviourEveryNInvinsibleOnWait.setTurnWait(turnWait)
		
	func setLimit(newLimit):
		limit = newLimit
		turnBehaviour.setLimit(limit)
	
	func turn(pos):
		return behaviourEveryNInvinsibleOnWait.turn(pos)
	
	func getDamageable():
		return behaviourEveryNInvinsibleOnWait.getDamageable()

class WaitEveryN extends BaseTurn:
	var behaviour 
	var waitEvery = 3
	var counter = 0
	
	func _init(_character = null).(_character):
		pass
	
	func setWaitEvery(newWaitEvery):
		waitEvery = newWaitEvery
	
	func setBehaviour(newBehaviour):
		behaviour = newBehaviour
	
	func turn(pos):
		counter += 1
		if (counter % waitEvery != 0):
			return behaviour.turn(pos)
		else:
			return Enums.DIRECTION.NONE

class InRangeMoveToOtherwiseRandomWaitEveryNTurns extends BaseTurn:
	var turnBehaviour
	var waitEveryN
	var waitEvery = 3
	var limit = 10
	
	func _init(_character = null).(_character):
		turnBehaviour = InRangeMoveToOtherwiseRandom.new(_character)
		waitEveryN = WaitEveryN.new(_character)
		
		waitEveryN.setBehaviour(turnBehaviour)
		waitEveryN.setWaitEvery(waitEvery)
	
	func setWaitEvery(newWaitEvery):
		waitEvery = newWaitEvery
		waitEveryN.setWaitEvery(waitEvery)
		
	func setLimit(newLimit):
		limit = newLimit
		turnBehaviour.setLimit(limit)
	
	func turn(pos):
		return waitEveryN.turn(pos)

class InvincibleWaitEveryN extends BaseTurn:
	var behaviour 
	var waitEvery = 3
	var counter = 0
	var damageable = true
	
	func _init(_character = null).(_character):
		pass
	
	func setWaitEvery(newWaitEvery):
		waitEvery = newWaitEvery
	
	func setBehaviour(newBehaviour):
		behaviour = newBehaviour
	
	func turn(pos):
		counter += 1
		if (counter % waitEvery != 0):
			damageable = true
			return behaviour.turn(pos)
		else:
			damageable = false
			return Enums.DIRECTION.NONE
	
	func getDamageable():
		return damageable

class InRangeMoveToOtherwiseRandomInvincibleWaitEveryNTurns extends BaseTurn:
	var turnBehaviour
	var invincibleWaitEveryN
	var waitEvery = 3
	var limit = 10
	
	func _init(_character = null).(_character):
		turnBehaviour = InRangeMoveToOtherwiseRandom.new(_character)
		invincibleWaitEveryN = InvincibleWaitEveryN.new(_character)
	
		invincibleWaitEveryN.setBehaviour(turnBehaviour)
		invincibleWaitEveryN.setWaitEvery(waitEvery)
	
	func setWaitEvery(newWaitEvery):
		waitEvery = newWaitEvery
		invincibleWaitEveryN.setWaitEvery(waitEvery)
		
	func setLimit(newLimit):
		limit = newLimit
		turnBehaviour.setLimit(limit)
	
	func turn(pos):
		return invincibleWaitEveryN.turn(pos)
	
	func getDamageable():
		return invincibleWaitEveryN.getDamageable()
