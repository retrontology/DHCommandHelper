proc(_scan, @intervalInSeconds, @player)
{
  @timeout = 0
  @increment = @intervalInSeconds * 1000
  @originalLocation = ploc(player())
  
  set_pmode(player(), 'SPECTATOR')
  if(pmode(player()) != 'SPECTATOR', die(color(c).'Scan Failed. Please talk to the administator.'))
  
  set_ploc(player(), @originalLocation)
  try(
    if(@player != null)
    {
      if(is_numeric(@player))
      {
        @increment = @player * 1000
        msg('Surveillance time set to '.@player.' seconds')
        msg('Scanning all players...')
        @timeout = _scanAll(@timeout, @increment)
      }
      else
      {
        if(player(@player) == player())
        {
          msg(color(c).'You can\'t scan yourself.... stupid.')
        }
        else
        {
          @timeout = _scanPlayer(@player, @timeout, @increment)
        }
      }
    }
    else
    {
      msg('Scanning all players...')
      @timeout = _scanAll(@timeout, @increment)
    }
  , @ex,
    msg('Error has occured. Scanning all players...')
    @timeout = _scanAll(@timeout, @increment)
  )
  set_timeout(@timeout,
    closure(
      set_ploc(player(), @originalLocation)
      if(_isAcey(player()))
      {
        set_pmode(player(), 'CREATIVE')
      }
      else
      {
        set_pmode(player(), 'SURVIVAL')
      }
    )
  )
}

proc(_scanAll, @timeout, @increment)
{
  foreach(@player in all_players())
  {
    if(player(@player) != player())
    {
      set_timeout(@timeout, closure(_checkView(@player)))
      @timeout += @increment
    }
  }
  return(@timeout)
}

proc(_scanPlayer, @player, @timeout, @increment)
{
  if(player(@player) != player())
  {
    if(_isAcey(@player), tmsg(@player, player()." is watching you."))
    set_timeout(@timeout, closure(_checkView(@player)))
    @timeout += @increment
  }
  return(@timeout)
}

proc(_checkView, @player)
{
  msg('Player: '.@player)
  set_ploc(player(), ploc(@player))
}