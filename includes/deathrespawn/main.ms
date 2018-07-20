include('display.ms')

proc(_isElite, @player)
{
  @groups = pinfo(@player, 9)
  foreach(@group in @groups)
  {
    if(@group == 'elite', return(true))
  }
  return(false)
}

proc(_isExempt, @player)
{
  @exemptWorlds = array('Parkour', 'Marshacre', 'Tartaros', 'Brookcastle')
  foreach(@world in @exemptWorlds)
  {
    if(pworld(@player) == @world, return(true))
  }
  return(false)
}

proc(_getLanternSpawn)
{
  @tpPoint = array( 0:10000.9, 1:64.0, 2:10000.9, 3:'Parkour', 
                    x:10000.9, y:64.0, z:10000.9, world:'Parkour')
  return(@tpPoint)
}

proc(_tpToGrim, @player)
{
  @lanternSpawn = _getLanternSpawn()
  @metadata = array(direction:2, name:'Grim\'s Lantern', subtitle:'Return to your home or to a safe haven')
  @tpPoint = array_merge(@lanternSpawn, @metadata)
  
  set_ploc(@player, @tpPoint);
  pfacing(@player, @tpPoint[direction]);
  
  runas('~console', '/title '. @player. ' title {"text":"~'.@tpPoint[name].'~", "color":"red"} ')
  runas('~console', '/title '. @player. ' subtitle {"text":"'.@tpPoint[subtitle].'", "color":"white"} ')
  
  _messageSequenceGrim(@player)
  
}

proc(_returnToSpawn, @player)
{
  sudo('/espawn')
  console('Sending '.@player.' to their elected spawn point...(Handled by Essentials)')
  set_peffect(@player, 15, 1, 3)
  set_peffect(@player, 9, 1, 10)
  tmsg(@player, 'You have respawned at Sanctuary')
}

proc(_respawnSelector, @player)
{
  if(_isElite(@player))
  {
    _returnToDeathPoint(@player)
  }
  else
  {
    _returnToHome(@player)
  }
}

proc(_returnToHome, @player)
{
  capture_runas('~console', '/adjustbonusclaimblocks '.@player.' -100')
  console('Sending '.@player.' to their home')
  sudo('/ehome')
  
  # Do some near death effects over here
  set_peffect(@player, 15, 1, 3)
  set_peffect(@player, 9, 1, 10)
  set_phealth(@player, 8)
  set_phunger(@player, 5)
  
  msg(color(l).'At the cost of '.color(o).'100 claimblocks...')
  msg('\t...your soul returns to the place of your hearth...') 
  msg('\t\t...you wake up disorientated.')
}

proc(_returnToDeathPoint, @player)
{
  @deathLoc = _getLastDeathPoint(@player)
  capture_runas('~console', '/adjustbonusclaimblocks '.@player.' -100')
  console('Sending '.@player.' to their death point')
  set_ploc(@player, @deathLoc)
  
  # Do some near death effects over here
  set_peffect(@player, 15, 1, 3)
  set_peffect(@player, 9, 1, 10)
  set_phealth(@player, 8)
  set_phunger(@player, 5)
  
  msg('Due to your Elite Status, Grim has favoured you.')
  msg(color(l).'At the cost of '.color(o).'100 claimblocks...')
  msg('\t...your soul returns to your battered and beaten body...') 
  msg('\t\t...you wake up disorientated.')
  #_clearLastDeathPoint(@player)
}

proc(_saveLastDeathPoint, @player, @deathpoint)
{
  store_value('deathrespawn.deathpoint.'.@player, @deathpoint)
}

proc(_getLastDeathPoint, @player)
{
  return(get_value('deathrespawn.deathpoint.'.@player))
}

proc(_clearLastDeathPoint, @player)
{
  clear_value('deathrespawn.deathpoint.'.@player)
}

