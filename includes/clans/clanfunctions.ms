include('clans.ms')

/**
  * Add player to team
  * Usage: _addPlayer(@player, @clan)
  */
proc(_addPlayer, @player, @clan)
{
  team_add_player(@clan, @player, _getScoreboardName())
}

/**
  * Remove player from team
  * Usage: _removePlayer(@player, @clan)
  */
proc(_removePlayer, @player, @clan)
{
  team_remove_player(@clan, @player, _getScoreboardName())
}

/**
  * Get Clan Names
  * Returns array of clans 
  * Usage: _getClans()
  */
/*** PATCHED BY RETRO ***/ 
proc(_getAllClans)
{
  #@clans = get_teams(_getScoreboardName())
  #@clanList = array()
  #foreach(@clan in @clans)
  #{
  #  array_push(@clanList, @clan['name'])
  #}
  assign(@clanNames, array('DragonHunters',
						   'DragonRiders',
						   'DragonKin',
						   'Rogue'))
  @clans = get_teams(_getScoreboardName())
  @clanList = array()
  foreach(@clan in @clans)
  {
    if(array_contains(@clanNames, @clan['name']), array_push(@clanList, @clan['name']))
  }
  return(@clanList)
}

/**
  * Gets clans that can take in new recruits
  * Returns an array of recruiting clans
  * Usage: _getRecruitingClans()
  */
proc(_getRecruitingClans)
{
  @allClans = _getAllClans()
  array_remove_values(@allClans, 'Rogue')
  @recruitingClans = @allClans
  @smallestClan = _getSmallestClanSize();
  foreach(@clan in @recruitingClans)
  {
    @sizeDifference = _getClanSize(@clan) - @smallestClan
    if(@sizeDifference > 3)
    {
      array_remove_values(@recruitingClans, @clan)
    }
  }
  return(@recruitingClans)
}

/**
  * Checks if clan is valid
  * Returns boolean value
  * Usage: _isValidClan(@name)
  */
proc(_isValidClan, @name)
{
  @allClans = _getAllClans()
  foreach(@clan in @allClans)
  {
    if(@name == @clan)
    {
      return(true)
    }
  }
  return(false)
}

/**
  * Get Clan Information
  * Returns array with all clan information
  * Usage: _getClan(@clanname)
  */
proc(_getClan, @clanname)
{
  @clans = get_teams(_getScoreboardName())
  foreach(@clan in @clans)
  {
    if(@clanname == @clan['name'])
    {
      return(@clan)
    }
  }
  return()
}

/**
  * Get Clan Members
  * Returns array of users belonging into clan
  * Usage: _getClanMembers(@clan)
  */
proc(_getClanMembers, @clan)
{
  @clanInfo = _getClan(@clan)
  return(@clanInfo[players])
}

/**
  * Get Clan Size
  * Usage: _getClanSize(@clan)
  * Returns integer
  */
proc(_getClanSize, @clan)
{
  @size = array_size(_getClanMembers(@clan))
  return(@size)
}

/**
  * Gets the smallest clan's size
  * Returns integer
  * Usage: _getSmallestClanSize()
  */
proc(_getSmallestClanSize)
{
  @allClans = _getAllClans()
  array_remove_values(@allClans, 'Rogue')

  foreach(@clan in @allClans)
  {
    @currentClanSize = _getClanSize(@clan)
    @smallestSize = @currentClanSize
    if(@smallestSize > @currentClanSize)
    {
      @smallestSize = @currentClanSize
    }
    else
    {
      @smallestSize = @currentClanSize
    }
  }
  return(@smallestSize)
}
