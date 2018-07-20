proc(_citizen, @player)
{
  @citizenBonusClaimBlocks = 750
  
  runas('~console', '/adjustbonusclaimblocks '.@player.' '.@citizenBonusClaimBlocks)
  runas('~console', '/pex user '.@player.' group remove Visitor')
  runas('~console', '/pex user '.@player.' group add Citizen')
  
  #Make an announcement if the player is online. 
  if(ponline(@player)) 
  {
    sudo("/acc say Congratulations ".@player." on becoming a Dragonhollow Citizen!");

    #Inform player of their new privileges & gifts (if they're online)
    tmsg(@player, '---------------------------------------------')
    tmsg(@player, '| Congratulations on becoming a Dragonhollow Citizen!');
    tmsg(@player, '| You received an additional '.@citizenBonusClaimBlocks.' claimblocks');
    tmsg(@player, '| You can also change your display name');
    tmsg(@player, '| by using /nick <nickname>');
    tmsg(@player, '| and access your /profile');
    tmsg(@player, '---------------------------------------------')
  }
  
  #Inform command sender that the process is complete. 
  msg(@player, ' is now a Dragonhollow Citizen');
  
  #Log a console message;
  console(player().' has promoted '.@player.' to Citizen')
}

proc(_veteran, @player)
{
  @veteranBonusClaimBlocks = 1200

  runas('~console', '/adjustbonusclaimblocks '.@player.' '.@veteranBonusClaimBlocks)
  runas('~console', '/pex user '.@player.' group remove Citizen')
  runas('~console', '/pex user '.@player.' group add Veteran')
  
  #Make an announcement if the player is online. 
  if(ponline(@player)) 
  {
    sudo('/acc say Congratulations '.@player.' on becoming a Dragonhollow Veteran!');

    #Inform player of their new privileges & gifts (if they're online)
    tmsg(@player, '---------------------------------------------')
    tmsg(@player, '| You are now a Dragonhollow Veteran and')
    tmsg(@player, '| as such, you are now able to use commands such as...')
    tmsg(@player, '| * /hat - which uses the block you currently have')
    tmsg(@player, '|              on your hand as a hat')
    tmsg(@player, '| * /veterantrail - activates a trail that\'s')
    tmsg(@player, '|                        for veterans only')
    tmsg(@player, '|')
    tmsg(@player, '| You have also received '@veteranBonusClaimBlocks.' additional claimblocks')
    tmsg(@player, '| Thanks for your continuous support')
    tmsg(@player, '| on Dragonhollow')
    tmsg(@player, '---------------------------------------------')
  }
  
  #Inform command sender that the process is complete. 
  msg(@player, ' is now a Dragonhollow Veteran');
  #Log a console message;
  console(player().' has promoted '.@player.' to Veteran')
}