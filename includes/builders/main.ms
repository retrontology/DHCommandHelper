proc(_startBuild, @player, @world)
{
	if(array_contains(_getWorlds(), @world) == false, die(color(c).'You did not enter a valid build world'))
	if((get_inventory(puuid(@player)) != _emptyInventory()) && (@world != ploc()[world]), die(color(c).'Please empty your inventory before you start building'))
	if(@world != to_lower(ploc()[world]), sudo('/mvtp '.@world))
	set_timeout(1000, closure(){sudo('/creative')})
	console(player().' has started building')
}

proc(_stopBuild, @player)
{
	if(array_contains(_getWorlds(), to_lower(ploc()[world])))
	{
		sudo('/home')
		sudo('/survival')
		_clearInventory(@player)
		console(player().' has stopped building')
	}
	else
	{
		die(color(c).'You\'re not in a build world, find your own way home lol')
	}
}

proc(_clearInventory, @player)
{
	set_inventory(puuid(@player), _emptyInventory())
}

proc(_emptyInventory)
{
	return(array(0: null, 1: null, 10: null, 11: null, 12: null, 13: null, 14: null, 15: null, 16: null, 17: null, 18: null, 19: null, 2: null, 20: null, 21: null, 22: null, 23: null, 24: null, 25: null, 26: null, 27: null, 28: null, 29: null, 3: null, 30: null, 31: null, 32: null, 33: null, 34: null, 35: null, 36: null, 37: null, 38: null, 39: null, 4: null, 40: null, 5: null, 6: null, 7: null, 8: null, 9: null))
}

proc(_getWorlds)
{
	return(array('hammerlea', 'sanctuary', 'hammerlea_nether', 'dragonhollow_events'))
}