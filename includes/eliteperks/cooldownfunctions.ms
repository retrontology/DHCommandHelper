proc(_getCountDown, @milliseconds)
{
  @remaining = _convertToTime(@milliseconds)
  return(@remaining[time])
}

#
# ----> CLAIM BONUS CLAIMBLOCKS
#

proc(_getLastUseBonusClaimblocks, @player)
{
  @uuid = puuid(@player, true)
  return(get_value(_getLastUseKeyBonusClaimBlocks(@uuid)))
}

proc(_setLastUseBonusClaimblocks, @player, @lastUse)
{
  # Set last use to current time if never been used
  if(@lastUse == '' || @lastUse == null, @lastUse = time()) 
  @uuid = puuid(@player, true)
  store_value(_getLastUseKeyBonusClaimBlocks(@uuid), @lastUse)
}

proc(_getLastUseKeyBonusClaimBlocks, @uuid)
{
  return('elite.bonusclaimblocks.cooldown.'.@uuid)
}

#
# ----> SKY CLEAR COOLDOWN FUNCTIONS
#

proc(_getLastUseSkyClear)
{
  return(get_value(_getLastUseKeySkyClear()))
}

proc(_setLastUseSkyClear, @lastUse)
{
  # Set last use to current time if never been used
  if(@lastUse == '' || @lastUse == null, @lastUse = time()) 
  console('\n[ElitePerks] Setting Sky Clear\'s last use value to: '.@lastUse)
  store_value(_getLastUseKeySkyClear(), @lastUse)
}

proc(_getLastUseKeySkyClear)
{
  return('elite.skyclear.cooldown')
}



#
# ----> TIMESKIP COOLDOWN FUNCTIONS
#

proc(_getLastUseTimeSkip)
{
  return(get_value(_getLastUseKeyTimeSkip()))
}

proc(_setLastUseTimeSkip, @lastUse)
{
  # Set last use to 0 if never been used
  if(@lastUse == '' || @lastUse == null, @lastUse = time()) 
  console('\n[ElitePerks] Setting TimeSkip\'s last use value to: '.@lastUse)
  store_value(_getLastUseKeyTimeSkip(), @lastUse)
}

proc(_getLastUseKeyTimeSkip)
{
  return('elite.timeskip.cooldown')
}