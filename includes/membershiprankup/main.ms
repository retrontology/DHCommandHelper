include('ranks.ms')
proc(_mpu, @rank, @args)
{
  
  #Check if there are no variables in the command
  #If there are none, display command usage help.
  if (@args == "", die(_help(@rank)))
  
  #Get the Player
  @args = parse_args(@args);
  
  #Display command usage help if user passes '?' as an argument
  if(@args[0] == '?', die(_help(@rank)))
  
  #Set @player as the first argument
  @player = @args[0];
  
  #Check if player entered exists...
  if(!_playerExists(@player), die(color(red).'Error: '.@player.' doesn\'t exist in the system. Suggest for them to log into Dragonhollow so that they can be promoted.'))
  
  _promote(@rank, @player)
}

proc(_playerExists, @player)
{
  @allPlayers = get_offline_players()
  foreach(@user in @allPlayers)
  {
    if(@player == @user, return(true))
  }
  return(false)
}

proc(_promote, @rank, @player)
{
  switch(@rank)
  {
    case 'citizen':
      _citizen(@player)
      break;
    case 'veteran':
      _veteran(@player)
      break;
  }
}

proc(_helpCitizen)
{
  @helpString = 'Usage: /citizen <player> \n'
  @helpString .= color(b).'REMINDER: Always check for user\'s real name! ' 
  @helpString .= 'Use /realname. Player names are CaSe-sEnSiTiVe. \n'
  @helpString .= color(7).' Sets the user\'s rank to Citizen. Perks: \n'
  @helpString .= color(7).' - Ability to set nickname using /nick \n'
  @helpString .= color(7).' - Gain set amount of bonus claimblocks upon rank-up'
  return(@helpString)
}

proc(_helpVeteran)
{
  @helpString = 'Usage: /veteran <player> \n'
  @helpString .= color(b).'REMINDER: Always check for user\'s real name! ' 
  @helpString .= 'Use /realname. Player names are CaSe-sEnSiTiVe. \n'
  @helpString .= color(7).' Sets the user\'s rank to Veteran. Perks: \n'
  @helpString .= color(7).' - Use of /hat \n'
  @helpString .= color(7).' - Gain set amount of bonus claimblocks upon rank-up'
  return(@helpString)
}

proc(_help, @rank)
{
  switch(@rank)
  {
    case 'citizen':
      return(_helpCitizen())
    case 'veteran':
      return(_helpVeteran())
    default:
      return('Something is wrong with the script. Please report to Acey')
  }
}
