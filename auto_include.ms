#===============================================================================
#
#   Sample external MethodScript include
#
#===============================================================================

/**
 *	Include other files
 */
include('includes/lootchests/main.ms')
 
/**
 *  Destroys Item on drop
 */
proc(_destroyOnDrop, @player)
{
  capture_runas(@player, "/remove drops 3")
}

/**
 *  Returns true if it's Acey!
 */
proc(_isAcey, @playerUUID)
{
  return(pinfo(@playerUUID,20) == 'cb8cf6be-131d-439a-ba76-2d44606d8147' || pinfo(@playerUUID,20) == 'c5eaedfd-db0a-48db-84a3-8da880b12ea8')
}

/**
 *  Returns true if it's the console
 */
proc(_isConsole, @playerUUID)
{
  return(pinfo(@playerUUID,20) == '~console')
}

/**
 * Returns a capitalized word.
 */
proc(_capitalize, @string)
{
  @strArray = split('', @string)
  @str = to_upper(@strArray[0])
  array_remove(@strArray, 0)
  foreach(@char in @strArray)
  {
    @str .= @char
  }
  return(@str)
}

/**
 * Returns true if given player is a citizen
 */
proc(_isCitizen, @player)
{
  @groups = pinfo(@player, 9)
  foreach(@group in @groups)
  {
    if(@group == 'citizen', return(true))
  }
  return(false)
}

/**
 * Returns true if given player is a veteran
 */
proc(_isVeteran, @player)
{
  @groups = pinfo(@player, 9)
  foreach(@group in @groups)
  {
    if(@group == 'veteran', return(true))
  }
  return(false)
}

/**
 * Returns true if given player is a elite
 */
proc(_isElite, @player)
{
  @groups = pinfo(@player, 9)
  foreach(@group in @groups)
  {
    if(@group == 'elite', return(true))
  }
  return(false)
}

/**
 * Returns true if player is in pvp combat (according to PVP manager)
 */
proc(_isInPvP, @player)
{ 
	# Check if PVP Manager is installed
	@plugins = get_server_info(9)
	if(!array_contains(@plugins, 'PvPManager')){ die('The plugin PvPManager is not loaded on this server.\n
								Please install it to check pvp status via this function') }
	
	# Check to see if player exists and is online
	if(!phas_played(@player)){ die('The requested player has not played on this server, thus their combat status cannot be checked') }
	if(!ponline(@player)){ die('The requested player is not online, thus their combat status cannot be checked') }
	
	# Run /pvpinfo command on requested player and parse for combat status
	@info = capture_runas(~console, /pvpinfo @player)
	@info = strip_colors(@info) 
	@info = replace(@info, '-', '')
	@args = parse_args(@info);
	@combat = array_get(@args, array_index(@args, 'Combat:') + 1)
	
	# Return combat status as boolean
	if(@combat == 'true'){ return(true) }
	else{ return(false) }
}

# Returns whether or not the give entity is on a rail
proc(_isOnRail, @ent)
{
	@loc = entity_loc(@ent)
	@block = get_block_at(@loc[x], @loc[y], @loc[z], @loc[world])
	return(reg_match('(66|27|28|157)(:)(\\d)+', @block) != array())
}

/**
 * Player Overrids permissions. Currently only works for Acey
 * Usage: _ifOverrideRun(@player, @command, @err)
 */
proc(_ifOverrideRun, @player, @command, @err)
{
  if(_isAcey(@player))
  {
    run(@command)
    console(@player.' performed an override for command: '.@command)
  }
  else
  {
    die(@err)
  }
}

# /**
  # * Returns true if in @location
  # */
# proc(_isInRegion, @location, @player)
# {
  # @regions = sk_current_regions(@player)
  # foreach(@region in @regions)
  # {
    # if(@location == @region, return(true))
  # }
  # return(false)
# }


/**
 * Returns UUID from player name.
 */
proc(_getUUID, @player)
{
  return(pinfo(@player,20))
}

# Returns an X/Z offset based off the provided yaw (in degrees -180<=yaw<180) and distance (in blocks)
# Works well for player yaw in particular
proc(_getXZOffset, @yaw, @distance)
{
	return(array('x': -sin(to_radians(@yaw))*@distance, 'z': cos(to_radians(@yaw))*@distance))
}

/**
 * Returns the distance between two blocks, or any other 3d points, for that matter.
 * @param array @arr1 The first point, expects an array of x, y, z
 * @param array @arr2 The second point, expects an array of x, y, z
 */
proc(_3d_distance, @arr1, @arr2,
    return(
        floor(
            sqrt(				
                  ((@arr2[0] - @arr1[0]) ** 2)
				+ ((@arr2[1] - @arr1[1]) ** 2)
				+ ((@arr2[2] - @arr1[2]) ** 2)
            )
        )
    )
)

proc(_2d_distance, @arr1, @arr2,
    return(
        floor(
            sqrt(				
                  ((@arr2[0] - @arr1[0]) ** 2)
				+ ((@arr2[2] - @arr1[2]) ** 2)
            )
        )
    )
)

/**
 * Given two blocks, iterates through all the blocks inside the cuboid, and calls the 
 * user defined function on them. The used defined procedure should accept 3 parameters,
 * the x, y, and z coordinates of the block.
 */
proc(_iterate_cuboid, @b1, @b2, @proc_name,
        for(assign(@x, min(@b1[0], @b2[0])), @x <= max(@b1[0], @b2[0]), @x++,
                for(assign(@y, min(@b1[1], @b2[1])), @y <= max(@b1[1], @b2[1]), @y++,
                        for(assign(@z, min(@b1[2], @b2[2])), @z <= max(@b1[2], @b2[2]), @z++,
                                call_proc(@proc_name, @x, @y, @z)
                        )
                )
        )
)