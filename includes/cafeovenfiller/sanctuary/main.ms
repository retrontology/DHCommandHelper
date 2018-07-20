/**
 * Returns oven location 
 * Usage: _getOven('location')
 */
proc(_getOven, @key)
{
  /*
   * Array of Cafe Oven Locations
   */
  @cof_CafeOven = array(
                        Sanctuary1: array(0:75.0,1:158.0, 2:-41.0, 3:'Sanctuary', world:'Sanctuary', x:75.0, y:158.0, z:-41.0),
                        Sanctuary2: array(0:74.0,1:158.0, 2:-41.0, 3:'Sanctuary', world:'Sanctuary', x:74.0, y:158.0, z:-41.0),
                        Sanctuary3: array(0:73.0,1:158.0, 2:-41.0, 3:'Sanctuary', world:'Sanctuary', x:73.0, y:158.0, z:-41.0),
                  )
  if(@cof_CafeOven[@key] != null)
  {
    return(@cof_CafeOven[@key])
  }
  else
  {
    die('This oven does not exist.')
  }
}

/** 
 * Returns fill amount depending on the time of day.
 * Usage: _setMultiplier()
 */
proc(_setMultiplier)
{
  @intervals = array(2000, 6000, 13500); 
  @multiplier = 1;
  @currentTime = get_world_time('Sanctuary');
  #Are there spare bread from the rest of the day? If so... Give more bread.
  foreach(@interval in @intervals) {
    if(@currentTime > @interval, @multiplier++);
  }
  return(@multiplier)
}

/**
 * Returns a randomly generated amount to fill
 * oven with while factoring in the supplied
 * multiplier
 * Usage: _getFillAmount(@multiplier)
 */
proc(_getFillAmount, @multiplier)
{
  @amount = 0;
  for(@i = 0, @i < @multiplier, @i++)
  {
    @amount += rand(0,3);
  }
  
  return(@amount)
}


/*
 * Return item to fill into the oven
 * Randomizes as either cake or bread
 * Currently set to 20% chance of cake.
 * Usage: _getItemID()
 */
proc(_getItemID)
{
  if(rand(1,100) < 80) 
  {
    return(297)
  }
  else 
  {
    return(354)
  }
}


/**
 * Returns an array with the itemID
 * amount of items and the item name
 * array(itemID:@itemID, amount:@amount, itemName:@itemName)
 * Usage: _getBatch()
 */

proc(_getBatch)
{
  @itemID = _getItemID();
  @amount = 0;
  
  if(@itemID == 297)
  {
    @itemName = "bread"
    @amount = _getFillAmount(_setMultiplier());
  }
  if(@itemID == 354)
  {
    @itemName = "cake"
    @amount = 1
  }
  @batch = array(itemID:@itemID, amount:@amount, itemName:@itemName)
  return(@batch)
}


/**
 * Fills the oven with either a random amounnt of bread
 * or one cake at a given location.
 * Usage: _fillOven(@location)
 */
proc(_fillOven, @location)
{
  @locationArray = _getOven(@location)
  @batch = _getBatch();
  if(@batch[amount] > 0) 
  {
    set_block_at(@locationArray, '62')
    set_inventory(@locationArray, array(2:array(type:@batch[itemID], qty:@batch[amount])))
    console('Oven has been filled! '
            . @batch[amount] . ' ' 
            . @batch[itemName] . ' from the oven at '
            . @location)
  }
  else 
  {
    console('The food that was at ' . @location
            . ' was left in the oven too long and was burnt to a crisp')
  }
}
