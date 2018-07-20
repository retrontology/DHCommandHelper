include('prizetokens.ms')

proc(_Participant, @player)
{
  msg("Thank for for participating in our event! You have received a Prize Token x20")
  _giveTokenx20(1, @player)
}

proc(_CakeRunHM, @player)
{
  broadcast(color(7)."[DH Herald]".color(e)." Congratulations to ".@player." for completing the Cake Run Hard Mode")
  msg("You have received a Prize Token x100")
  _giveTokenx100(1, @player)
}

proc(_TopSurvivorPrizeKit, @rank, @player)
{
  switch(@rank)
  {
    case 1:
      broadcast(color(7)."[DH Herald]".color(e)." Congratulations to ".@player." for achieving first place on the Top Survivors Scoreboard")
      msg("You have received a Prize Token x500 and 1000 xp")
      _giveTokenx500(1, @player)
      give_pexp(@player, 1000)
      break();
    case 2:
      broadcast(color(7)."[DH Herald]".color(e)." Congratulations to ".@player." for achieving second place on the Top Survivors Scoreboard")
      msg("You have received three Prize Token x100 and 500 xp")
      _giveTokenx100(3, @player)
      give_pexp(@player, 500)
      break();
    case 3:
      broadcast(color(7)."[DH Herald]".color(e)." Congratulations to ".@player." for achieving third place on the Top Survivors Scoreboard")
      msg("You have received a Prize Token x100 and 300 xp")
      _giveTokenx100(1, @player)
      give_pexp(@player, 300)
      break();
  }
}

proc(_BBCPrizeKitApril2015, @player)
{
  msg(color(7)."[DH Herald]".color(e)." Congratulations to ".@player." for winning the April 2015 Best Build Contest")
}

proc(_RacerPrizePack, @rank, @player)
{
  switch(@rank)
  {
    case 1:
      msg(color(l)."Congratulations on winning 1st place on the race!")
      msg("As part of your prize pack, you have received:")
      msg("\t- Luxurious Saddle")
      msg("\t- Golden Horse Armor")
      msg("\t- Name Tag")
      msg("\t- 32 Gold Ingots")
      msg("\t- Three Prize Token x100")
      msg("\t- and 300 xp")
      pgive_item(@player, 329, 1, array(display:'Luxurious Saddle', lore:array('Made out of the finest', 'luxurious leather',' ','Property of '.@player))) # Saddle
      pgive_item(@player, 418, 1, array(display:'Golden Horse Armor', lore:array('Specially forged for the', '1st place winner of the Eastbrook Races',' ','Property of '.@player))) # Golden Horse Armor
      pgive_item(@player, 421, 1) # Name Tag
      pgive_item(@player, 266, 32) # Gold Ingots
      _giveTokenx100(3, @player)
      give_pexp(@player, 300)
      break();
    case 2:
      msg(color(l)."Congratulations on winning 2nd place on the race!")
      msg("As part of your prize pack, you have received:")
      msg("\t- Light Weight Saddle")
      msg("\t- Silver Horse Armor")
      msg("\t- 16 Gold Ingots")
      msg("\t- Two Prize Token x100")
      msg("\t- and 200 xp")
      pgive_item(@player, 329, 1, array(display:'Light Weight Saddle', lore:array('Engineered for speed', 'and comfort',' ','Property of '.@player))) # Saddle
      pgive_item(@player, 417, 1, array(display:'Silver Horse Armor', lore:array('Specially forged for the', '2nd place winner of the Eastbrook Races',' ','Property of '.@player))) # Iron Horse Armor
      pgive_item(@player, 266, 16) # Gold Ingots
      _giveTokenx100(2, @player)
      give_pexp(@player, 200)
      break();
    case 3:
      msg(color(l)."Congratulations on winning 3rd place on the race!")
      msg("As part of your prize pack, you have received:")
      msg("\t- Old-fashioned Saddle")
      msg("\t- 8 Gold Ingots")
      msg("\t- Prize Token x100")
      msg("\t- and 100 xp")
      pgive_item(@player, 329, 1, array(display:'Old-fashioned Saddle', lore:array('Modelled to look like', 'a prop from a cowboy movie',' ','Property of '.@player))) # Saddle
      pgive_item(@player, 266, 8) # Gold Ingots
      _giveTokenx100(1, @player)
      give_pexp(@player, 100)
      break();
  }
}
proc(_BrookcastleHelperReward, @player)
{
  @bonusClaimblock = 200
  msg("The newbie that you helped out wanted to thank you by sending you this reward pack!")
  runas('~console','/adjustbonusclaimblocks '.@player.' '.@bonusClaimblock)
  msg("You have received ".@bonusClaimblock." claimblocks")
  _giveTokenx20(1, @player)
}

proc(_givePrize, @player, @prizeKey)
{
  switch(@prizeKey)
  {
    case 'Helpful-Helper':
      _BrookcastleHelperReward(@player)
      break();
    case 'Racer-1stPlace':
      msg('You have unlocked the First Place Racer Prize Pack')
      msg('with the prize key "'.@prizeKey.'"')
      _RacerPrizePack(1, @player)
      break()
    case 'Racer-2ndPlace':
      msg('You have unlocked the Second Place Racer Prize Pack')
      msg('with the prize key "'.@prizeKey.'"')
      _RacerPrizePack(2, @player)
      break()
    case 'Racer-3rdPlace':
      msg('You have unlocked the Third Place Racer Prize Pack')
      msg('with the prize key "'.@prizeKey.'"')
      _RacerPrizePack(3, @player)
      break()
    case 'BBC':
      msg('You have unlocked the Best Build Contest April 2015 Winner Prize Kit')
      msg('with the prize key "'.@prizeKey.'"')
      _BBCPrizeKitApril2015(@player)
      break()
    case 'Survivor-1stPlace':
      msg('You have unlocked the First Place Top Survivor')
      msg('with the prize key "'.@prizeKey.'"')
      _TopSurvivorPrizeKit(1, @player)
      break()
    case 'Survivor-2ndPlace':
      msg('You have unlocked the Second Place Top Survivor')
      msg('with the prize key "'.@prizeKey.'"')
      _TopSurvivorPrizeKit(2, @player)
      break()
    case 'Survivor-3rdPlace':
      msg('You have unlocked the third Place Top Survivor')
      msg('with the prize key "'.@prizeKey.'"')
      _TopSurvivorPrizeKit(3, @player)
      break()
    case 'CakeRunHM':
      msg('You have unlocked Cake Run Hard Mode Prize')
      msg('with the prize key "'.@prizeKey.'"')
      _CakeRunHM(@player)
    case 'Participant':
      msg('You have unlocked a participation prize')
      msg('with the prize key "'.@prizeKey.'"')
      _Participant(@player)
    default:
      msg("You have an invalid prize key, stop cheating!")
  }
}