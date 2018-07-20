proc(_listPlayersProximity, @player)
{
	@worlds = array('Sanctuary', 'Hammerlea')
	@all = all_players()
	array_remove_values(@all, @player)
	@players = array()
	foreach(@p in @all)
	{
		@loc = ploc(@p)
		if(_hasJammer(@p) == false && pmode(@p) == 'SURVIVAL' && array_contains(@worlds, @loc['world']))
		{
			array_push(@players, array('name':@p, 'distance': _3d_distance(ploc(@player), @loc)))
		}
	}
	@players = _sortPlayerDistanceArray(@players)
	return(@players)
}

proc(_sortPlayerDistanceArray, @players)
{
	@players = array_sort(@players, closure(@left, @right){
		return(@left['distance'] > @right['distance'])
	})
	return(@players)
}

proc(_getClosestPLoc, @player)
{
	@target = _getClosestPlayer(@player)
	if(@target != null)
	{
		return(ploc(@target['name']))
	}
	else
	{
		return(null)
	}
}

proc(_getClosestPlayer, @player)
{
	@players = _listPlayersProximity(@player)
	if(@players == array())
	{
		return(null)
	}
	else
	{
		return(@players[0])
	}
}

proc(_hasJammer, @player)
{
	foreach(@item in pinv(@player))
	{
		if(_isJammer(@item), return(true))
	}
	return(false)
}

proc(_isJammer, @item)
{
	if(@item == null, return(false))
	if( @item['type'] == '369' &&
		array_index_exists(@item, 'enchants') &&
		@item['enchants'] == array(array(elevel: 10, etype: DIG_SPEED)) &&
		array_index_exists(@item, 'meta') &&
		array_index_exists(@item['meta'], 'display') &&
		@item['meta']['display'] == 'Tracker Jammer' &&
		array_index_exists(@item['meta'], 'lore') &&
		@item['meta']['lore'] == array('Tastes like raspberry...'))
	{
		return(true)
	}
	else
	{
		return(false)
	}
}

proc(_setTracker, @player)
{
	@worlds = array('Sanctuary', 'Hammerlea')
	@target = _getClosestPlayer(@player)
	if(array_contains(@worlds, ploc(@player)['world']) == false)
	{
		tmsg(player(), color(c).'You are not in a valid world to use the tracker')
		return(false)
	}
	if(@target != null)
	{
		if(@target['distance'] <= 150)
		{
			tmsg(player(), color(e).'You are too close to your target to use the tracker')
			return(false)
		}
		else
		{
			set_compass_target(@player, _obfuscateLocation(ploc(@target['name'])))
			console(@player . ' is now tracking ' . @target['name'])
			tmsg(player(), color(a).'Tracker Set!')
			return(true)
		}
	}
	else
	{
		tmsg(player(), color(c).'Could not find a valid target :(')
		return(false)
	}
}
proc(_obfuscateLocation, @loc)
{
	@loc[0] = @loc[0] + (rand(0,100) - 50)
	@loc[2] = @loc[2] + (rand(0,100) - 50)
	@loc[x] = @loc[0]
	@loc[z] = @loc[2]
	return(@loc)
}