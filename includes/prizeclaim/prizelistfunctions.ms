
/**
 *  Returns an array of the 
 *  current list of Players
 *  who has a pending prize claim
 */
proc(_getPrizeList)
{
  return(get_value('prizeclaim.pendingprizes'))
}

proc(_savePrizeList, @list)
{
  store_value('prizeclaim.pendingprizes', @list)
}

proc(_printPrizeList)
{
  @list = _getPrizeList()
  msg(color(l).'=============== Prize List ===============')
  
  if(@list == null, die(color(c)."There are no prizes waiting to be claimed."))
  
  foreach(@entry in @list)
  {
    @playerUUID = @entry[uuid]
    @player = @entry[player]
    @prizeKey = @entry[prizekey]
    
    msg(@player": ".@prizeKey)
    msg("\t".@playerUUID)
    msg(color(7).color(o)."\tLast Seen: ".simple_date('MMMMM d, yyyy. hh:mm a',plast_played(@player)))
  }
}

proc(_hasPendingPrizes, @player)
{
  @pendingForPlayer = _getPlayerPrizeList(@player)
  if(array_size(@pendingForPlayer) > 0)
  {
    return(true)
  }
  return(false)
}

proc(_clearPrizeList)
{
  @list = array()
  _savePrizeList(@list)
  msg("Prize List has been emptied.")
}

/**
 *  Add a new player to the player prize list
 */
proc(_addPrize, @player, @prizeName)
{
  # Get existing list
  @list = _getPrizeList()
  if(@list == null, @list = array())
  
  # Add item to the existing list
  @prizeEntry = array(uuid:puuid(@player), player:@player, prizekey:@prizeName)
  array_push(@list, @prizeEntry)

  msg("Added prize with prize key ".@prizeName)
  msg("\tto be claimed by ".@player)
  if(ponline(@player))
  {
    tmsg(@player, "You have received the prize key '".@prizeName."'")
    tmsg(@player, "Type /claimprizes to claim it!")
  }
  
  # SAVE current list
  _savePrizeList(@list)
}

/**
 *  Removes a prize from the prize list
 */
proc(_removePrize, @player, @prizeKey)
{
  @list = _getPrizeList()
  @counter = 0
  foreach(@entry in @list)
  {
    if((@entry[uuid] == pinfo(@player, 20) || @entry[player] == @player)
        && @entry[prizekey] == @prizeKey)
    {
      array_remove(@list, @counter)
      _savePrizeList(@list)
      msg(color(7).color(o)."The prize key \"".@prizeKey."\" for ".@player)
      msg(color(7).color(o)." has been taken from the prize list")
      return()
    }
    @counter++
  }
  msg("There is no pending prize with the prize key ".@prizeKey." for ".@player)
}


proc(_getPlayerPrizeList, @player)
{
  @prizeList = _getPrizeList()
  if(@prizeList == null, @prizeList = array())
  
  @pendingForPlayer = array();
  foreach(@entry in @prizeList)
  {
    if(pinfo(player(@player), 20) == @entry[uuid])
    {
      array_push(@pendingForPlayer, @entry)
    }
  }
  return(@pendingForPlayer)
}


