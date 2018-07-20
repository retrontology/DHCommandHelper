/**
 *  CRON JOBS
 */

# ---> START FREE FOOD AT THE OVENS AT THE CAFE IN SANCTUARY
set_cron('*/5 * * * *', closure(
  include('includes/cafeovenfiller/sanctuary/main.ms')
  _fillOven('Sanctuary1')
))
set_cron('*/18 * * * *', closure(
  include('includes/cafeovenfiller/sanctuary/main.ms')
  _fillOven('Sanctuary3')
))
# ---> END FREE FOOD AT THE OVENS AT THE CAFE IN SANCTUARY


/**
 *  EVENT BINDS
 */

bind(player_consume, null, null, @event,
	console('player: '. @event['player'])
	console('item: '. @event['item'])
)
 
bind(entity_death, null, null, @event,
  @multipliedXP = @event['xp'] * 3
  modify_event('xp', @multipliedXP)
) 
/** broken silk spawner method
bind(block_break, null, array(type:52), @event,
	# Silk Touch II Spawner Mechanism
	@item = pinv(@event['player'], pheld_slot(@event['player']))
	if(array_index_exists(@item, 'enchants'))
	{
		foreach(@enchant in @item['enchants'])
		{
			if(@enchant['etype'] == 'SILK_TOUCH' && @enchant['elevel'] == 2)
			{  
				# modify drops later
				console(@event['location'])
				console(get_block_at(@event['location']['x'], @event['location']['y'], @event['location']['z'], @event['location']['world']))
				#modify_event('drops', @drops)
			}
		}
	}
  )
**/


# Fracture Mechanic
bind(block_break, null, array(type:1), @event,  
  @canBuild = sk_can_build(@event['player'], @event['location']) && has_gp_buildperm(@event['player'], @event['location'])
  if(pmode(@event['player']) == 'SURVIVAL' && @canBuild)
  {
	#Grab Info
    include('includes/randomevents/retromine.ms')
	@item = pinv(@event['player'], pheld_slot(@event['player']))
	@chance = 25
	
	# Check to see if player is using silk touch and set chance to 0 if they are
	if(array_index_exists(@item, 'enchants'))
	{
		foreach(@enchant in @item['enchants'])
		{
			if(@enchant['etype'] == 'SILK_TOUCH'){ @chance = 0 }
		}
	}
	if(@chance != 0)
	{
		switch(@item['type'])
		{
			case 270:
				tmsg(@event['player'], color(c)."You must use a stone pick, or better, to break stone.")
				cancel()
				return()
			case 274:
				@chance = 20;
				break();
			case 257:
				@chance = 15;
				break();
			case 285:
				@chance = 10
				break();
			case 278:
				@chance = 5
				break();
			default:
				@chance = 25
		}
		_main(@event['location'], @chance, 0)
	}
    
  }
)

# BROOOMS
bind(hanging_break, null , array(world:'Sanctuary'), @event,
	include('includes/brooms/main.ms')
	_respawnBroom(@event)
)

# Negative levitation does no fall damage
bind(entity_damage, null, array(type:'PLAYER', cause:'FALL', ), @event,
	@effects = get_peffect(@event['player'])
	if(@effects != array())
	{
		foreach(@key: @effect in @effects)
		{
			if(@effect[id] == 25 && @effect[strength] == -4)
			{
				# remove effect if they took a doozy
				if(@event['finalamount'] >= 10, set_peffect(@event['player'], 25, 0, 0))
				modify_event('amount', 0)
				cancel()
				break()
			}
		}
	}
)

# Minecart return mechanic
bind(vehicle_leave, null, array(vehicletype:'MINECART', passengertype:'PLAYER'), @event,
	if(_isOnRail(@event['vehicle']))
	{
		entity_remove(@event['vehicle'])
		if(add_to_inventory(entity_id(puuid(@event['player'])), 328, 1) != 0)
		{
			drop_item(@event['player'], array(type: '328', data: 0, qty: 1))
		}
	}
)

/*
bind(player_join, null, null, @event,
  # ---> START World Expansion Mechanic
  if(@event['first_login'] == 'true')
  # if(@event['player'] == 'AceyXx')
  {
	@distance = rand(200,1000)
    console('New player '.@event['player'].' joined!')
    sudo('/worldborder add '.@distance)
    set_timeout('1000', closure(){
      runas('~console', '/acc say The airship has discovered more land before it landed on the shores of Hallowmere')
    })
  }
  # ---> END World Expansion Mechanic
)
*/

bind(player_death, null, null, @event,
  # ---> START Grim Respawn Mechanic
  include('includes/deathrespawn/main.ms')
  _saveLastDeathPoint(@event['player'], ploc(@event['player']))
  # ---> END Grim Respawn Mechanic
)

bind(player_spawn, null, null, @event,
  # ---> START Grim Respawn Mechanic
  include('includes/deathrespawn/main.ms')
  set_timeout(10, closure(){
    if(!_isExempt(@event['player']))
    {
      _tpToGrim(@event['player'])
    }
  })
  # ---> END Grim Respawn Mechanic
)

bind(item_drop, null, null, @event,
  include('includes/soulbounditems/main.ms')
  if(_isSoulBound(@event['item']), cancel())
)

bind(player_enter_bed, null, null, @event,
  # ---> START BED REGEN (SLEEP) MECHANIC
    include('includes/bedregen/main.ms')
    console('\n[BedREGEN] '.@event[player].' has entered a bed.')
    # Set Sleep Counter for Waking Up benefits
    @sleepCounter = 0
    export(_getSleepCounterKey(@event['player']), @sleepCounter)
    
    # Get in Bed!
    if(!_canEnterBed(@event['player']))
    {
      tmsg(@event[player], color(l).color(c).'You feel restless and can\'t fall asleep')
      cancel()
    }
    if(!is_cancelled())
    {
      _doSleepCycle(@event['player'])
    }
  # ---> END BED REGEN (SLEEP) MECHANIC
)

bind(player_leave_bed, null, null, @event,
  # ---> START BED REGEN (SLEEP) MECHANIC
    include('includes/bedregen/main.ms')
    console('\n\t[BedREGEN]'.@event[player].' has woken up!')
    _wakeUp(@event['player'])
  # ---> END BED REGEN (SLEEP) MECHANIC
  
  # ---> START Underground Teleport Mechanism
  include('includes/rainbownebulas/main.ms')
	@shipbedSanctuary = array(
							  array(0:163.0, 1:132.0, 2:90.0, 3:'Sanctuary', world:'Sanctuary', x:163.0, y:132.0, z:90.0),
							  array(0:164.0, 1:133.0, 2:90.0, 3:'Sanctuary', world:'Sanctuary', x:164.0, y:133.0, z:90.0),
							  array(0:163.0, 1:132.0, 2:84.0, 3:'Sanctuary', world:'Sanctuary', x:163.0, y:132.0, z:84.0),
							  array(0:164.0, 1:133.0, 2:84.0, 3:'Sanctuary', world:'Sanctuary', x:164.0, y:133.0, z:84.0),
							  
							  array(0:155.0, 1:132.0, 2:90.0, 3:'Sanctuary', world:'Sanctuary', x:155.0, y:132.0, z:90.0),
							  array(0:154.0, 1:133.0, 2:90.0, 3:'Sanctuary', world:'Sanctuary', x:154.0, y:133.0, z:90.0),
							  array(0:155.0, 1:132.0, 2:84.0, 3:'Sanctuary', world:'Sanctuary', x:155.0, y:132.0, z:84.0),
							  array(0:154.0, 1:133.0, 2:84.0, 3:'Sanctuary', world:'Sanctuary', x:154.0, y:133.0, z:84.0),
							  
							  array(0:157.0, 1:132.0, 2:82.0, 3:'Sanctuary', world:'Sanctuary', x:157.0, y:132.0, z:82.0),
							  array(0:157.0, 1:133.0, 2:81.0, 3:'Sanctuary', world:'Sanctuary', x:157.0, y:133.0, z:81.0),
							  array(0:161.0, 1:132.0, 2:82.0, 3:'Sanctuary', world:'Sanctuary', x:161.0, y:132.0, z:82.0),
							  array(0:161.0, 1:133.0, 2:81.0, 3:'Sanctuary', world:'Sanctuary', x:161.0, y:133.0, z:81.0),
							  )
    @shipbed3 = array(0:247.0, 1:109.0, 2:807.0, 3:'Sanctuary', world:'Sanctuary', x:247.0, y:109.0, z:807.0)
    @shipbed4 = array(0:247.0, 1:109.0, 2:805.0, 3:'Sanctuary', world:'Sanctuary', x:247.0, y:109.0, z:805.0)
	@slot = _hasItem(@event[player])
    if(array_contains(@shipbedSanctuary, @event[location]) && @slot != -1)
    {
	  _takeItem(@event[player], @slot)
      tmsg(@event[player], 'The Rainbow Nebulas has docked at Tortuga')
      sudo('/mvtp a:rainbownebulas-tortuga')
    }
    if(@event[location] == @shipbed3
        || @event[location] == @shipbed4)
    {
      tmsg(@event[player], 'The Rainbow Nebulas has docked at Blackbourne')
      sudo('/mvtp a:rainbownebulas-sanctuary')
    }
    
  # ---> END Underground Teleport Mechanism
)

# Killer Rabbit
bind(item_held, null, null, @event,
  @chance = rand(0,100)
  if(@chance == 1)
  {
	@item = pinv(@event['player'], @event['to'])
	if(is_array(@item) && array_index_exists(@item, 'type') && @item['type'] == 391)
	{
	  tmsg(@event['player'], color(l)."Eh, what's up doc?")
      console('[RandomEVENT] '.@event['player']." found a wabbit!")
	  @rchance = rand(0,2)
	  @offset = _getXZOffset(ploc(@event['player'])['yaw'], 3)
	  if(@rchance == 1)
	  {
		sudo('/summon minecraft:rabbit ~' . string(@offset['x']) . ' ~ ~' . string(@offset['z']) . ' 
		{
			RabbitType:99,
			Attributes:
			[
				{Name:"generic.followRange",Base:64},
				{Name:"generic.knockbackResistance",Base:0.75f},
				{Name:"generic.movementSpeed",Base:1.5f}
			]
		}'
		)
	  }
	  else
	  {
	    sudo('/summon minecraft:rabbit ~' . string(@offset['x']) . ' ~ ~' . string(@offset['z']) . ' {RabbitType:1}')
	  }
	}
  }
)

bind(player_fish, null, null, @event,
  @chance = rand(0,100)
  
  if(@chance == 1 && @event['state'] == 'CAUGHT_FISH')
  {
    tmsg(@event['player'], color(l)."You caught a big fish!")
    console('[RandomEVENT] '.@event['player']." caught a big fish!")
    spawn_entity('guardian', 1, pcursor(@event['player']))
  }
)

bind(player_toggle_sprint, null, array(world: 'Sanctuary'), @event,
  # ---> START ELITE NINJA RUN MECHANIC
    include('includes/eliteperks/main.ms')
    if(@event['sprinting'] == true 
      && _canNinjaRun(@event['player']))
    {
      set_peffect(@event['player'], 1, 5, 10)
      set_peffect(@event['player'], 8, 10, 10)
    }
  # ---> END ELITE NINJA RUN MECHANIC
)

bind(player_toggle_sneak, null, array(world: 'Sanctuary'), @event,
  # ---> START ELITE NINJA RUN MECHANIC
    include('includes/eliteperks/main.ms')
    if(@event['sneaking'] == true 
      && _canNinjaRun(@event['player']))
    {
      set_peffect(@event['player'], 25, 254, 2)
    }
  # ---> END ELITE NINJA RUN MECHANIC
)

# Sanctuary tp floor
bind(player_move, null, array(world:'Sanctuary', threshold: 20), @event,
  @coords = ploc(@event['player'])
  if(@coords[y] < 15)
  {
	# Cakerun
	if(@coords[x] <= 8 && @coords[x] >= -103 && @coords[z] <= -77 && @coords[z] >= -103)
	{
      #@coords[y] = 122.5
	  @coords[y] = 200
      @coords[1] = 200
	  @coords[x] = 8.5
	  @coords[0] = 8.5
	  @coords[z] = -90.5
	  @coords[2] = -90.5
	  @coords[yaw] = 90
	  @coords[4] = 90
	  console(@coords)
	}
	#everywhere else in sanc
	else
	{
	  @coords[world] = 'Hammerlea'
      @coords[3] = 'Hammerlea'
      @coords[y] = 350
      @coords[1] = 350
      set_peffect(@event['player'], 25, 254, 5)
	  set_peffect(@event['player'], 1, 10, 5)
	  
	}
	set_peffect(@event['player'], 15, 1, 5)
    set_ploc(@event['player'], @coords)
	/* Old Clan Mechanic
	include('includes/clans/main.ms')
    if(_findPlayerClan(@event['player']) == null)
    {
      if(ponline('AceyXx')){ tmsg('AceyXx', @event['player'].' has jumped off Sanctuary and doesn\'t belong in a clan') }
      include('includes/clans/main.ms')
      _removeToken(@event['player'])
      _randomJoinClan(@event['player'])
    }
	*/
  }
)

#TP Ceiling mechanic
bind(player_move, null, array(world:'Hammerlea', threshold: 20), @event,
	@coords = ploc(@event['player'])
	if(@coords[y] >= 420)
	{
		@coords[y] = 50
		@coords[1] = 50
		@coords[world] = 'Sanctuary'
		@coords[3] = 'Sanctuary'
		set_ploc(@event['player'], @coords)
	}
)
 
 
#bind(block_break, null, null, @event,
  #include('includes/randomevents/mining.ms')
  #if(_isOreDust(@event['block']['type']))
  #{
  #  _dropGold(@event)
  #}
#)