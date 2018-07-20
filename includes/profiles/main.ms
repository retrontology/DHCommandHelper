include('../survivorscoreboard/main.ms')
proc(_profiles, @player)
{
  try(
    @err = color(c).'You do not have permissions to look up another player\'s profile'
    if(@player == '')
    {
      @player = player()
    }
    else
    {
      if(_isCitizen(player()), 
        die(@err))
      if(_isVeteran(player()), 
        die(@err))
    }
    
    @player = player(@player)
    @profile = ''
    @profile .= color(2).'====================================================='.color(f)
    @profile .= '\tName: '._getRealName(@player).' '
    @profile .= 'a.k.a. '._getCurrentNickname(@player).'\n'
    @profile .= '\t[Level: '._getCurrentLevel(@player).']>> '
    @profile .= 'KDR: '._getKills(@player).'/'._getDeaths(@player).'\n'.color(7).color(o)
    @profile .= '\t\tMembership: '._getMembership(@player).'\n'
    @profile .= '\t\tSpawned in Summergate: '._getFirstJoined(@player).'\n'
    @profile .= '\t\tTime since last death: '._getCurrentTimeAlive(@player).'\n \n'.color(r)
    @profile .= '\tLast Seen: '._getLastSeen(@player).'\n'
    @profile .= color(2).'====================================================='
  , @ex,
    if(@ex[0] == PlayerOfflineException)
    {
      @profile = ''
      @profile .= color(c).'====================================================='.color(f)
      @profile .= '\tName: '._getRealName(@player).'\n'
      @profile .= '\tSpawned in Summergate: '._getFirstJoined(@player).'\n\n'
      @profile .= '\tTime since last death: '._getCurrentTimeAlive(@player).'\n'
      @profile .= '\tLast Seen: '._getLastSeen(@player).'\n'
      @profile .= color(c).'====================================================='
    }
    if(@ex[0] == InsufficientPermissionException)
    {
      @err = color(c).'====================================================='.color(f)
      @err .= '\tYou must be a Citizen to look at player profiles. \n'
      @err .= '\tTo become a Citizen visit http://goo.gl/PNVSB3 \n'
      @err .= '\tand follow the steps.\n'
      @err .= '\tCurrent Membership: '.color(7).'Visitor'
      @err .= color(c).'====================================================='
      die(@err)
    }
  )
  msg(@profile)
}

proc(_getCurrentNickname, @player)
{
  return(pinfo(@player, 4))
}

proc(_getRealName, @player)
{
  try(
    return(pinfo(@player, 0))
  , @ex, 
    if(@ex[0] == PlayerOfflineException)
    {
      if(phas_played(@player))
      {
        return(@player)
      }
      die(color(c).'This player has never logged into Dragonhollow.')
    }
  )
}

proc(_getFirstJoined, @player)
{
  return(simple_date('MMMMM d, yyyy. hh:mm a' ,pfirst_played(@player)))
}

proc(_getMembership, @player)
{
  @listArray = pinfo(@player, 9)
  @list = ''
  if(array_size(@listArray) > 1)
  {
    for(@i=0, @i <= array_size(@listArray) - 2, @i++)
    {
      @list .= _capitalize(@listArray[@i]) .', '
    }
    @lastIndex = array_size(@listArray) - 1
    @list .= _capitalize(@listArray[@lastIndex])
  }
  else
  {
    @list = _capitalize(@listArray[0]);
  }
  return(@list)
}

proc(_getCurrentTimeAlive, @player)
{
  @time = _convertToTime(get_pscore('ticksAlive', @player))
  return(@time[time])
}

proc(_getLastSeen, @player)
{
  if(ponline(@player))
  {
    return(color(a).'Online')
  }
  else
  {
    return(simple_date('MMMMM d, yyyy. hh:mm a',plast_played(@player)))
  }
}

proc(_getCurrentLevel, @player)
{
  return(plevel(@player))
}

proc(_getKills, @player)
{
  return(get_pscore('PlayerKills', @player))
}

proc(_getDeaths, @player)
{
  return(get_pscore('Deaths', @player))
}