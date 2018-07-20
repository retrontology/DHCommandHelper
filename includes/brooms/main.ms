proc(_isBroom, @event)
{
	@brooms = array(
					array(0: 118.03125, 1: 154.5, 2: 96.5, 3: Sanctuary, 4: 270.0, 5: 0.0, pitch: 0.0, world: Sanctuary, x: 118.03125, y: 154.5, yaw: 270.0, z: 96.5),
					array(0: 118.03125, 1: 154.5, 2: 95.5, 3: Sanctuary, 4: 270.0, 5: 0.0, pitch: 0.0, world: Sanctuary, x: 118.03125, y: 154.5, yaw: 270.0, z: 95.5),
					array(0: 118.03125, 1: 154.5, 2: 94.5, 3: Sanctuary, 4: 270.0, 5: 0.0, pitch: 0.0, world: Sanctuary, x: 118.03125, y: 154.5, yaw: 270.0, z: 94.5)
					)
	if(@event[type] == 'ITEM_FRAME' && array_contains(@brooms, @event[location]))
	{
		return(true)
	}
	return(false)
}

proc(_respawnBroom, @event)
{
	if(_isBroom(@event))
	{
		sudo('/summon item_frame ' . string(@event[location][x]) . ' ' . string(@event[location][y]) . ' ' . string(@event[location][z]) . ' {Item:{id:arrow,tag:{display:{Name:\"\\\"Broom\\\"\"}},Count:1b},Facing:3,ItemRotation:7}')
	}
}