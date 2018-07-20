proc(_hearthstoneHome)
{
  if(!_itemExists(), die('You do not have a hearthstone'))
  if(_restrictedWorld(), die('Your hearthstone\'s magic is fading, you can\'t use your hearthstone in this world.'))
  #Set level cost per teleport
  @levelCost = 5
  if(_isElite(), @levelCost = 3)
  
  #Get player's current level
  @currentLevel = plevel(player());
  
  if(@currentLevel >= @levelCost)
  {
    msg('You have been teleported home at the cost of '.@levelCost.' levels')
    sudo('/home')
    console('\n[Hearthstones] '.player().' has teleported home.')
    set_plevel(player(), @currentLevel - @levelCost)
  }
  else
  {
    msg('You do not have enough levels. You need at least '.@levelCost.' levels to use the hearthstone to teleport home.')
  }
}

proc(_hearthstoneSetHome)
{
  if(!_itemExists(), die('You do not have a hearthstone'))
  if(_restrictedWorld(), die('Your hearthstone\'s magic is fading, you can\'t set your hearthstone in this world.'))
  #Set level cost per teleport
  @levelCost = 2;
  if(_isElite(), @levelCost = 1)
  
  #Get player's current level
  @currentLevel = plevel(player());
  
  
  if(@currentLevel >= @levelCost)
  {
    msg('You have set your new home at the cost of '.@levelCost.' levels')
    sudo('/sethome')
    @newcoords = ploc();
    console('\n[Hearthstones] '.player().' has set their home at '.@newcoords[world].' at X:'.@newcoords[x].' Y:'.@newcoords[y].' Z:'.@newcoords[z])
    set_plevel(player(), @currentLevel - @levelCost)
  }
  else
  {
    msg('You do not have enough levels. You need at least '.@levelCost.' levels to use the hearthstone to teleport home.')
  }
}

proc(_restrictedWorld)
{
  @restrictedWorlds = array(
                      "Parkour",
                      "Arena",
                      "Brookcastle"
                      )
  foreach(@world in @restrictedWorlds)
  {
    if(pworld(player()) == @world, return(true))
  }
  return(false)
}

proc(_isElite)
{
  @groups = pgroup();
  foreach(@group in @groups)
  {
    if(@group == 'elite', return(true))
  }
  return(false)
}

proc(_itemExists)
{
  @heartstone = array(
                  type: 318,
                  name: 'FLINT',
                    meta: array(
                            display: Hearthstone, 
                            lore: array('Allows for fast travel, to your house,  , Left-click to go home, Right-click to set home'), 
                            enchants: array(array(elevel: 10, etype: DIG_SPEED))
                          )
                )
  @playerHand = pinv(player(),pinfo(player(),15))
  
  if(player() == 'AceyXx', return(true))
  
  #If the player's hand is null, item doesn't exist
  if(@playerHand == null, return(false))

  #If the current item on hand's name doesn't match, item doesn't exist
  if(@playerHand[name] != @heartstone[name], return(false))

  #If the current item on hand's itemID doesn't match, item doesn't exist
  if(@playerHand[type] != @heartstone[type], return(false))

  #If the current item on hand's display name doesn't match, item doesn't exist
  if(@playerHand[meta][display] != @heartstone[meta][display], return(false))

  #If the current item on hand's lore doesn't match, item doesn't exist
  if(@playerHand[meta][lore] != @heartstone[meta][lore], return(false))

  #If the current item on hand's enchantments doesn't match, item doesn't exist  
  if(@playerHand[meta][enchants] != @heartstone[meta][enchants], return(false))
    
  return(true)
}