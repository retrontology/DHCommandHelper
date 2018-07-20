/**
  * Use to give or take permissions from players
  * depending on the clan that they have joined
  * Usage: _clanPermissions(@clanname, @addremove)
  */
proc(_clanPermissions, @clanname, @addremove, @player)
{
  @permissionGroup = 'Clan-'.@clanname
  if(@addremove == 'add')
  {
    runas('~console', '/pex user '.@player.' group add '.@permissionGroup)
  }
  else if(@addremove == 'remove')
  {
    runas('~console', '/pex user '.@player.' group remove '.@permissionGroup)
  }
  else
  {
    die('You done fucked up... it\'s "add" or "remove" no caps or anything');
  }
}

proc(_setMembership, @player)
{
  @memberships = pinfo(@player, 9)
  foreach(@membership in @memberships)
  {
    if(@membership == "Owner")
    {
      @membership = "Owner"
    }
    if(@membership == "Veteran")
    {
      @membership = "Veteran"
    }
    if(@membership == "Citizen")
    {
      @membership = "Citizen"
    }
    if(@membership == "Visitor")
    {
      @membership = "Visitor"
    }
  }
  runas('~console', '/pex user '.@player.' group add '.@membership)
}