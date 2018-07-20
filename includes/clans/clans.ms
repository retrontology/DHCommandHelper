proc(_getScoreboardName)
{
  return('main')
}

/**
  * Create the clans!
  * Usage: _createClans()
  */
proc(_createClans)
{
  # DRAGONHUNTERS
  @clanname = 'DragonHunters'
  create_team(@clanname, _getScoreboardName())
  _setTeamParams(@clanname, 'dark_purple')
  # @options = _getTeamParams('default', 'dark_purple')
  # set_team_options(@clanname, @options, _getScoreboardName())

  
  # DRAGONRIDERS
  @clanname = 'DragonRiders'
  create_team(@clanname, _getScoreboardName())
  _setTeamParams(@clanname, 'dark_blue')
  # @options = _getTeamParams('default', 'dark_blue')
  # set_team_options(@clanname, @options, _getScoreboardName())
  
  # DRAGONKIN
  @clanname = 'DragonKin'
  create_team(@clanname, _getScoreboardName())
  _setTeamParams(@clanname, 'dark_green')
  # @options = _getTeamParams('default', 'dark_green')
  # set_team_options(@clanname, @options, _getScoreboardName())
  
  # ROGUES
  @clanname = 'Rogue'
  create_team(@clanname, _getScoreboardName())
  _setTeamParams(@clanname, 'dark_gray')
  # @options = _getTeamParams('rogue', 'dark_grey')
  # set_team_options(@clanname, @options, _getScoreboardName())
}

/**
  * Deletes All the Clans
  * Usage: _deleteClans()
  */
proc(_deleteClans)
{
  remove_team('DragonHunters')
  remove_team('DragonRiders')
  remove_team('DragonKin')
  remove_team('Rogue')
}

/**
  * Get the team's options depending on the team type
  * Usage: _getTeamParams(@teamType, @color)
  */
proc(_setTeamParams, @clan, @color, @teamtype)
{ 
  if(@clan == 'Rogue')
  {
    run('/scoreboard teams option '.@clan.' color '.@color)
    run('/scoreboard teams option '.@clan.' friendlyfire true')
    run('/scoreboard teams option '.@clan.' seeFriendlyInvisibles true')
    run('/scoreboard teams option '.@clan.' nametagVisibility never')
    run('/scoreboard teams option '.@clan.' deathMessageVisibility never')
  }
  else
  {
    run('/scoreboard teams option '.@clan.' color '.@color)
    run('/scoreboard teams option '.@clan.' friendlyfire false')
    run('/scoreboard teams option '.@clan.' seeFriendlyInvisibles true')
    run('/scoreboard teams option '.@clan.' nametagVisibility hideForOtherTeams')
    run('/scoreboard teams option '.@clan.' deathMessageVisibility hideForOtherTeams')
  }
}
