/*
 * Returns available patterns for specified arena
 * Usage: _getPatterns(@arena)
 */
proc(_getPatterns, @arena)
{
  switch(@arena)
  {
    case 'marshacre-tournament':
      @patterns = array (
                          #Hidden Parkour
                          array (
                            #Pumpkin Biome
                            _chest(306,9,928,'Arena',1,'military'),
                            _chest(349,5,929,'Arena',2,'general'),
                            #Crazy Hills
                            _chest(360,7,985,'Arena',3,'potions'),
                            _chest(341,22,996,'Arena',1,'general'),
                            #Lake
                            _chest(341,22,996,'Arena',1,'military'),
                            _chest(325,5,1051,'Arena',1,'potions'),
                            #Desert
                            _chest(251,26,1063,'Arena',3,'potions'),
                            _chest(231,10,1046,'Arena',3,'military'),
                            #Mesa
                            _chest(175,25,1040,'Arena',3,'general'),
                            _chest(153,5,1043,'Arena',2,'general'),
                            #Ice Spikes
                            _chest(204,6,993,'Arena',2,'military'),
                            _chest(155,23,1005,'Arena',1,'military'),
                            #Mushroom Biome/End
                            _chest(145,17,917,'Arena',3,'general'),
                            _chest(199,7,944,'Arena',1,'potions'),
                            #Forest
                            _chest(254,17,961,'Arena',1,'military'),
                            _chest(265,5,928,'Arena',2,'general'),
                            #Roundabout
                            _chest(279,6,1014,'Arena',3,'potions'),
                            _chest(232,5,988,'Arena',2,'general')
                          ),
                          #Hey! It's a whaaat?
                          array (
                            #Pumpkin Biome
                            _chest(306,9,928,'Arena',1,'military'),
                            _chest(349,5,929,'Arena',2,'general'),
                            #Crazy Hills
                            _chest(360,7,985,'Arena',3,'potions'),
                            _chest(341,22,996,'Arena',1,'general'),
                            #Lake
                            _chest(341,22,996,'Arena',1,'military'),
                            _chest(325,5,1051,'Arena',1,'potions'),
                            #Desert
                            _chest(251,26,1063,'Arena',3,'potions'),
                            _chest(231,10,1046,'Arena',3,'military'),
                            #Mesa
                            _chest(175,25,1040,'Arena',3,'general'),
                            _chest(153,5,1043,'Arena',2,'general'),
                            #Ice Spikes
                            _chest(204,6,993,'Arena',2,'military'),
                            _chest(155,23,1005,'Arena',1,'military'),
                            #Mushroom Biome/End
                            _chest(145,17,917,'Arena',3,'general'),
                            _chest(199,7,944,'Arena',1,'potions'),
                            #Forest
                            _chest(254,17,961,'Arena',1,'military'),
                            _chest(265,5,928,'Arena',2,'general'),
                            #Roundabout
                            _chest(279,6,1014,'Arena',3,'potions'),
                            _chest(232,5,988,'Arena',2,'general')
                          ),
                        )
      break;
    default:
      console('Error: There are no specified patterns for ' . @arena)
  }
  return(@patterns)
}

/*
 * Returns a chest with it's parameters
 * Usage: _chest(@x, @y, @z, @world, @rarity, @chestType)
 * @x = Chest's X coordinate; @y = Chest's Y coordinates; @z = Chest's Z coordinates 
 * @world = World it belongs to
 * @rarity = Chest's rarity level. 
 *            1 - Common. Open air location, easily spotted from a distance
 *            2 - Uncommon. Hard to spot if not looking for.
 *            3 - Rare. I could've sworn the chest was there....
 * @chestType = Specifies the chest's type. 
 *              - general > contains everything
 *              - military > contains gear
 *              - potions > contains potions
 */
proc(_chest, @x, @y, @z, @world, @rarity, @chestType)
{
  @chest = array(
                  location:array(0:@x, 1:@y, 2:@z, 3:@world, world:@world, x:@x, y:@y, z:@z),
                  rarity: @rarity,
                  chestType: @chestType
                )
  return(@chest)
}
