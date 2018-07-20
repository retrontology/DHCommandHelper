include('cooldownfunctions.ms')
include('realtimeconverter.ms')

proc(_getClaimBlocks, @remote)
{
  @amount = 300
  @cooldown = 10800000 # 3 hours in milliseconds
  @currentTime= time()
  @nextAvailable = _getLastUseBonusClaimblocks(player()) + @cooldown
  @timeRemaining = @nextAvailable - @currentTime
  if(@nextAvailable > @currentTime)
  {
    tmsg(player(), 'You can\'t claim your bonus claimblocks at this time.')
    tmsg(player(), 'You\'ll be able to claim your bonus claimblocks again in') 
    tmsg(player(), _getCountDown(@timeRemaining))

    if(@remote == 'true')
    {
      # Give item back
      capture_runas('~console','/comitems give Elite-BonusClaimBlocks -p '.player())
    }
    die()
  }
  sudo('/adjustbonusclaimblocks '.player().' '.@amount)
  msg('You have received 300 bonus claimblocks')
  _setLastUseBonusClaimblocks(player(), time())
  
}

proc(_skyClear, @remote)
{
  #@cooldown = 10800 # For testing purposes only
  @cooldown = 10800000 # 3 hours in milliseconds
  @currentTime = time()
  @nextAvailable = _getLastUseSkyClear() + @cooldown
  @timeRemaining = @nextAvailable - @currentTime
  
  if(@nextAvailable > @currentTime)
  {
    tmsg(player(), 'You can\'t perform a Sky Clear at this time')
    tmsg(player(), 'A Sky Clear will be available in ' _getCountDown(@timeRemaining))
    if(@remote == 'true')
    {
      capture_runas('~console','/comitems give Elite-SkyClear -p '.player())
    }
    die()
  }
  console('The sky has cleared!')
  broadcast(color(l).color(o).player().' is performing a rain dance, pleading the gods to clear the skies!')
  
  set_timeout(5000, closure(){
    broadcast('The sky is clearing and the rain is disappearing!')
    storm(false, _getWorldName(), 24000)
    _setLastUseSkyClear(time())
  })  
}

proc(_timeSkip, @remote)
{ 
  #@cooldown = 10800 # For testing purposes only
  @cooldown = 10800000 # 3 hours in milliseconds
  @timeSkipAmount = 8000 # 8000 = 8 in game hours
  
  @currentWorldTime = get_world_time()
  @newWorldTime = @currentWorldTime + @timeSkipAmount
  if(@newWorldTime > 24000)
  {
    @newWorldTime = @newWorldTime - 24000
  }
  
  @currentTime = time()
  @nextAvailable = _getLastUseTimeSkip() + @cooldown
  @timeRemaining = @nextAvailable - @currentTime
  

  if(@nextAvailable > @currentTime)
  {
    tmsg(player(), 'You can\'t perform a Time Skip at this time')
    tmsg(player(), 'A Time Skip will be available in ' _getCountDown(@timeRemaining))
    if(@remote == 'true')
    {
      tmsg('AceyXx', @remote)
      # Give item back
      capture_runas('~console','/comitems give Elite-TimeSkip -p '.player())
    }
    die()
  }
  
  @duration = 3
  foreach(@player in all_players())
  {
   
    set_pwalkspeed(@player, 0.06)
    set_timeout(@duration * 1000, closure(){
      set_pwalkspeed(@player, 0.2)
    })
    set_peffect(@player, 1, 10, @duration, true, false) # Speed
    set_peffect(@player, 4, 10, @duration, true, false) # Mining Fatigue
    set_peffect(@player, 24, 0, @duration, true, false) # Glowing
    set_peffect(@player, 14, 0, @duration, true, false) # Invisibility
    set_peffect(@player, 8, 128, @duration, true, false) # Jump Boost
    set_peffect(@player, 16, 1, @duration, true, false) # Night Vision
    set_peffect(@player, 11, 5, @duration, true, false) # Resistance
    set_peffect(@player, 13, 5, @duration, true, false) # Water Breathing
  }
  
  broadcast(color(l).color(o).'A time skip has occurred!')
  broadcast('\t'.player().' has successfully pushed time forward!')
  set_world_time(_getWorldName(), @newWorldTime)
  _setLastUseTimeSkip(time())
}

proc(_canNinjaRun, @player)
{
  if(!has_permission('elite.ninjarun.sanctuary'), return(false))
  if(!pinfo(@player, 18) == false, return(false))
  #if(!_isInRegion('sanctuary', @player), return(false))
  return(true)
}

proc(_getWorldName)
{
  return('Hammerlea')
}