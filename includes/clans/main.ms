include('permissions.ms')
include('clanfunctions.ms')
include('clans.ms')

/**
  * Join a clan
  * Usage: _joinClan(@player, @clan)
  */
proc(_joinClan, @player, @clan)
{
  # Leave any existing clan
  _leaveClan(@player)
  
  # Join scoreboard team
  _addPlayer(@player, @clan)
  
  # Add group permissions
  _setMembership(@player)
  _clanPermissions(@clan, 'add', @player)
  tmsg(@player,'You have joined '.@clan)
  tmsg(@player,'The '.@clan.' gate and the FFA gate is now open to you')
  tmsg(@player,'If you need more information about the clan system')
  tmsg(@player,'Pick up a clan guide!')
  switch(@clan)
  {
    case 'DragonHunters':
      capture_runas('~console', '/acc say '.@player.' has joined the &5DragonHunters')
    break()
    case 'DragonRiders':
      capture_runas('~console', '/acc say '.@player.' has joined the &1DragonRiders')
    break()
    case 'DragonKin':
      capture_runas('~console', '/acc say '.@player.' has joined the &2DragonKin')
    break()
    case 'Rogue':
      capture_runas('~console', '/acc say '.@player.' has gone &8Rogue')
    break()
  }
  
}

/**
  * Join a random clan. Used for new players
  * Usage: _randomJoinClan(@player)
  */
proc(_randomJoinClan, @player)
{
  # Get qualified clans, excluding Rogue
  @clans = _getRecruitingClans()

  # Select one randomly from list
  @selectedClan = array_rand(@clans)
  # Have player join that clan
  _joinClan(@player, @clans[@selectedClan[0]])
}

/**
  * Leave a clan
  * Usage: /leaveclan <clan_name> <player>
  */
proc(_leaveClan, @player)
{
  # Get all available scoreboard teams
  @clans = _getAllClans()
  
  foreach(@clan in @clans)
  {
    # Remove group permission
    _clanPermissions(@clan, 'remove', @player)
  }
}

/**
  * Find player's clan
  * Usage: /findclan <player>
  * Returns clan name
  */
proc(_findPlayerClan, @player)
{
   @clans = _getAllClans();
   foreach(@clan in @clans)
   {
      @members = _getClanMembers(@clan)
      foreach(@clanMember in @members)
      {
         if(@player == @clanMember)
         {
            return(@clan)
         }
      }
   }
   return(null)
}

/**
  * Remove Join Clan Token from player's inventory
  * Usage: _removeToken(@player)
  */
proc(_removeToken, @player)
{
  include('../soulbounditems/main.ms')
  @token = _getItem(1)
  @playerInventory = pinv(@player)
  foreach(@item in @playerInventory)
  {
    if(@item != null)
    {
      if(_sameItem(@item, @token))
      {
        # WARNING:  ptake_item() only distinguishes by item ID.
        #           in this case, it's taking any End Crystal
        #           it finds. BE REALLY CAREFUL!
        ptake_item(@player, @item[type],1)
        break()
      }
    }
  }
}