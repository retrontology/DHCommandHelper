proc(_squid, @args)
{
	@defquantity = 16
	# if command is just /squid
	if(@args == '') 
	{
		@players = all_players()
		foreach(@player in @players)
		{
			_squidSplosion(@player, @defquantity)
		}
		die();
	}
	
	@args = parse_args(@args)
	
	# Help command
	if(@args[0] == '?')
	{
		die('Command Usage: /squid <player/all> <amount>')
	}
	
	#set target according to @args[0]
	if(@args[0] != null)
	{
		@target = to_lower(@args[0])
		if(@target == 'all')
		{
			@target = all_players()
		}
		else
		{
			if(phas_played(@args[0]) && ponline(@args[0]))
				{
					@target = @args[0]
				}
				else
				{
					die('Invalid player')
				}
		}
		switch(@target)
		{
			case 'all':
				
				break()
			default:
				
		}
		
		#set quantity according to args[1]
		@quantity = @defquantity;
		if(array_size(@args) == 2)
		{

			if(is_integral(@args[1]))
			{
				@quantity = parse_int(@args[1], 10)
			}
			else
			{
				die('Invalid quantity')
			}
		}
		
		#Execute command with requested parameters
		if(is_array(@target))
		{
			foreach(@player in @target)
			{
				_squidSplosion(@player, @quantity)
			}
		}
		else
		{
			_squidSplosion(@target, @quantity)
		}
		
	}
}

proc(_squidSplosion, @player, @quantity)
{
	@coords = ploc(@player)
	@coords[1] = @coords[1] + 2
	@coords[y] = @coords[y] + 2
	@squids = spawn_entity(SQUID, @quantity, @coords)
	foreach(@squid in @squids)
	{
		@eloc = entity_loc(@squid)
		@eloc[5] = rand()*180-90
		@eloc[pitch] = @eloc[5]
		@eloc[4] = rand()*359.9-180
		@eloc[yaw] = @eloc[4]

		set_entity_loc(@squid, @eloc)
		set_entity_velocity(@squid, array(rand()*4-2, rand(), rand()*4-2))
	}
}