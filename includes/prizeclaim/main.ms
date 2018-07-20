include('prizelistfunctions.ms')
include('prizepool.ms')

proc(_claimPrizes, @player)
{
  if(_hasPendingPrizes(@player))
  {
    @pendingForPlayer = _getPlayerPrizeList(@player)
    foreach(@prize in @pendingForPlayer)
    {
      _givePrize(@player, @prize[prizekey])
      _removePrize(@player, @prize[prizekey])
    }
  }
  else
  {
    die('You don\'t have any prizes waiting for you :(')
  }
}
/**
 *  Checks if @player has a prize pending
 */
proc(_checkPrizeList, @player)
{
  if(_hasPendingPrizes(@player))
  {
    msg(color(l).'You have prizes waiting for you!')
    msg('Prize Keys: ')
    @pendingForPlayer = _getPlayerPrizeList(@player)
    foreach(@prize in @pendingForPlayer)
    {
      msg("\t- ".@prize[prizekey])
    }
    msg()
    msg(color(o)."To claim your prizes, type in /claimprizes")
  }
  else
  {
    msg('There are no prizes waiting for you :(')
  }
}
