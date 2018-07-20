/*
 * Returns the item pool from the item list provided.
 * Usage: _setItemPool(@itemList)
 */
proc(_setItemPool, @arena)
{
  @itemPool = array();
  @itemList = _setItemList(@arena)
  foreach(@item in @itemList)
  {
    for(@i=0, @i<@item[amount],@i++)
    {
      array_push(@itemPool, array(id:@item[id], maxQty:@item[maxQty]))
    }
  }
  return(@itemPool)
}


/*
 * Returns the corresponding item list that's available for the arena specified.
 * If the arena specified is invalid, the item list will return stones.
 * Usage: _setItemList(@arena)
 */
proc(_setItemList, @arena)
{
  switch(@arena)
  {
    case 'marshacre-tournament':
      @items = array(
                    _item(282, 4, 3, 1),            #Mushroom Soup for SoupPvP
                    _item('373:8257', 5, 3, 2),     #Potion of Regeneration 2:00
                    _item('373:8194', 10, 2, 2),    #Potion of Swiftness 3:00
                    _item('373:8197', 20, 1, 3),    #Potion of Healing
                    _item('373:8201', 10, 2, 1),    #Potion of Strength 3:00
                    _item(322, 10, 3, 3),           #Golden Apple
                    _item('322:1', 1,  3, 1),       #God Apple
                    _item(368, 10, 2, 3),           #Ender Pearls for Escape
                    _item(262, 30, 1, 32),          #Additional arrows for bows
                  )
      break;
    default:
      @items = array(
                    array(id:1, amount:20)            #Stone
                  )
  }
  return(@items);
}

/*
 * Returns an array with the item's parameters.
 * Usage: _items (@id, @amountForPool, @rarity, @maxQty)
 * @id = id of the item. Untested for meta data
 * @amountForPool = How many times do you want this item to occur in the item pool
 * @rarity = Level of chest rarity needed for this item to appear
 */
proc(_item, @id, @amountForPool, @rarity, @maxQty)
{
  return(array(id:@id, amount:@amountForPool, rarity: @rarity, maxQty: @maxQty))
}
