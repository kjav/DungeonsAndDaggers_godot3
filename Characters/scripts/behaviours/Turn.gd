class BaseTurn extends Node:
	func turn(pos):
		pass
	
	func afterMoveComplete(pos):
		pass

class MoveTo extends BaseTurn:
	func turn(pos):
		pos.x = int(pos.x / GameData.TileSize)
		pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.turn_end_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		return GameData.tilemap.findNextDirection(pos, player_pos)
	
	func getDistance(pos):
		var divided_pos = Vector2(0,0)
		divided_pos.x = int(pos.x / GameData.TileSize)
		divided_pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.turn_end_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		return GameData.tilemap.findPathDistance(divided_pos, player_pos)

class MoveRandom extends BaseTurn:
	func turn(pos):
		return randi()%5

class MoveToWaitBeforeAttackRecoverIfMissed extends BaseTurn:
	var moveTo = MoveTo.new()
	var waitAttackWaitCount = -1
	var attackDirection
	var recoveryTurn = false
	var additionalRelativeAttackPositions = []

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
				
				if recoveryTurn:
					setRecoveryForNextTurn()
				elif Attacking():
					if playerInAttackablePosition(player_pos, divided_pos, additionalRelativeAttackPositions):
						return moveTo.turn(pos)
					
					setRecoveryForNextTurn()
				else:
					LeaveWaitAttackWaitSequence()
					return turn(pos)
			else:
				var playerDirection = moveTo.turn(pos)
				
				if divided_pos.distance_squared_to(player_pos) > 1:
					return playerDirection
				else:
					attackDirection = playerDirection
					waitAttackWaitCount = 0
		
		return Enums.DIRECTION.NONE
	
	func playerInAttackablePosition(player_pos, divided_pos, additionalRelativeAttackPositions):
		var absolutePositions = PositionHelper.absoluteAttackPositions(PositionHelper.getNextTargetPos(divided_pos, attackDirection), additionalRelativeAttackPositions, attackDirection)
		
		for absolutePosition in absolutePositions:
			if (absolutePosition.x == player_pos.x and absolutePosition.y == player_pos.y):
				return true
		
		return false
	
	func setRecoveryForNextTurn():
		recoveryTurn = randi() % 2 == 1
	
	func PreparingAttack():
		return waitAttackWaitCount == 0
		
	func Attacking():
		return waitAttackWaitCount == 1
		
	func Recovering():
		return recoveryTurn
	
	func inWaitAttackWaitSequence():
		return waitAttackWaitCount >= 0
	
	func LeaveWaitAttackWaitSequence():
		waitAttackWaitCount = -1
		recoveryTurn = false

class InRangeMoveToOtherwiseRandom extends BaseTurn:
	var random = MoveRandom.new()
	var moveTo = MoveTo.new()
	var limit = 10
	
	func setLimit(newLimit):
		limit = newLimit

	func turn(pos):
		var divided_pos = Vector2(0,0)
		divided_pos.x = int(pos.x / GameData.TileSize)
		divided_pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.original_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		if GameData.player.alive() and moveTo.getDistance(pos) < limit:
			# Select movement direction towards player
			return moveTo.turn(pos)
		else:
			# Select random movement direction
			return random.turn(pos)

class BehaviourEveryN extends BaseTurn:
	var behaviour 
	var turnWait = 2
	var counter = 0
	
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
	var turnBehaviour = InRangeMoveToOtherwiseRandom.new()
	var behaviourEveryN = BehaviourEveryN.new()
	var turnWait = 2
	var limit = 10
	
	func init():
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
	var turnBehaviour = InRangeMoveToOtherwiseRandom.new()
	var behaviourEveryNInvinsibleOnWait = BehaviourEveryNInvinsibleOnWait.new()
	var turnWait = 2
	var limit = 10
	
	func init():
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
	var turnBehaviour = InRangeMoveToOtherwiseRandom.new()
	var waitEveryN = WaitEveryN.new()
	var waitEvery = 3
	var limit = 10
	
	func init():
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
	var turnBehaviour = InRangeMoveToOtherwiseRandom.new()
	var invincibleWaitEveryN = InvincibleWaitEveryN.new()
	var waitEvery = 3
	var limit = 10
	
	func init():
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
