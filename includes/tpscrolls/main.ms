include('teleport.ms')
proc(_teleportScrolls, @args)
{
  @err = "You do not have this teleport scroll on hand."
  #if command is /tpscroll
  if(@args == '') 
  {
    die('This command is used to operate the teleport scrolls. Should not be accessible in commandline. Type \'?\' for help')
  }
    @args = parse_args(@args)
  
  
  #if command is /tpscroll ?, display help.
  if(@args[0] == '?' && _isAcey(player()))
  {
    die('Command Usage: /tpscroll <location> <player>')
  }
  
  array_resize(@args, 3)

  if(@args[1] != null)
  {
    @player = @args[1]
  }
  else
  {
    @player = player()
  }
  
  if(_restrictedWorld(), die('Teleport Scrolls magic is ineffective in this world. You\'re going to need to find another way. \nYour teleport scroll has disappeared.'))
  
  if(_isInPvP(@player), die('You cannot use Teleport Scrolls while in PvP combat'))

  switch(@args[0]) 
  {
	case 'Hammerlea':
      tmsg(@player,'Welcome to The New World!')
      _teleport(@player,'Hammerlea')
      break()		
    case 'Sanctuary':
      tmsg(@player,'You have arrived in Sanctuary')
      _teleport(@player,'Sanctuary')
      break()
	case 'Marshacre':
      tmsg(@player,'You have arrived at Marshacre')
      _teleport(@player,'Marshacre')
      break()
	case 'Leingenwood':
      tmsg(@player,'You have arrived at Leingenwood Race Track')
      _teleport(@player,'Leingenwood')
      break()
    default:
      tmsg(@player,'Something has gone wrong, notify Acey that she messed up.')
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


proc(_itemExists, @location, @bypass)
{
  include('scrollslist.ms')
  @scroll = execute(@location, @getScroll)
  @playerHand = pinv(player(),pinfo(player(),15))
  
  # Uncomment lines below to show values being compared
  # and subsequent lines to show check values
  # msg(@scroll[meta][enchants])
  # msg(@playerHand[meta][enchants])
  
  @debug = false
  @debugInfo = ''
  
  #if(player() == 'AceyXx', return(true))
  if(@bypass == 'bypass', return(true))
  
  #If the player's hand is null, item doesn't exist
  @debugInfo .= '\nPlayer\'s Hand is null: '
  @debugInfo .= @playerHand == null
  if(@playerHand == null)
  {
    if(@debug = true, msg(@debugInfo))
    return(false)
  }  

  #If the current item on hand's name doesn't match, item doesn't exist
  @debugInfo .= '\nItem Name doesn\'t match: '
  @debugInfo .= @playerHand[name] != @scroll[name]
  if(@playerHand[name] != @scroll[name])
  {
    if(@debug = true, msg(@debugInfo))
    return(false)
  }  

  #If the current item on hand's itemID doesn't match, item doesn't exist
  @debugInfo .= '\nItemID doesn\'t match: '
  @debugInfo .= @playerHand[type] != @scroll[type]
  if(@playerHand[type] != @scroll[type])
  {
    if(@debug = true, msg(@debugInfo))
    return(false)
  }  

  #If the current item on hand's display name doesn't match, item doesn't exist
  @debugInfo .= '\nItem display name doesn\'t match: '
  @debugInfo .= @playerHand[meta][display] != @scroll[meta][display]
  if(@playerHand[meta][display] != @scroll[meta][display])
  {
    if(@debug = true, msg(@debugInfo))
    return(false)
  }  

  #If the current item on hand's lore doesn't match, item doesn't exist
  @debugInfo .= '\nItem lore doesn\'t match: '
  @debugInfo .= @playerHand[meta][lore] != @scroll[meta][lore]
  if(@playerHand[meta][lore] != @scroll[meta][lore])
  {
    if(@debug = true, msg(@debugInfo))
    return(false)
  }  

  #If the current item on hand's enchantments doesn't match, item doesn't exist
  @debugInfo .= '\nItem enchants doesn\'t match: '
  @debugInfo .= @playerHand[meta][enchants] != @scroll[meta][enchants]
  if(@playerHand[meta][enchants] != @scroll[meta][enchants])
  {
    if(@debug = true, msg(@debugInfo))
    return(false)
  }  
  return(true)
}