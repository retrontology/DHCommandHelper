include('ovens.ms')

/**
 * Main function for the Cafe Oven Filler
 * Takes in a location name and will check against the 
 * current known locations. If the location is known,
 * it will fill the oven up.
 * Usage: _cafeOvenFiller(@location)
 */
proc(_cafeOvenFiller, @location)
{
  @cooldown = 6000 #in ticks. This is every 5 minutes
  @currentTime = get_world_time();

  #Cafe Oven Cooldown
  @finishBakingTime = get_value('cooldowns.'.@location.'.cafe.oven');
  
  #If this is a new oven, it will be empty
  if(@finishBakingTime == null, @finishBakingTime = 0)

  #If you need to debug, uncomment the following line
  #_debugCafeOvenFillerLogic(@finishBakingTime, @cooldown, @currentTime)
  
  #If oven is done baking, give bread or
  if(_isDoneBakingBatch(@currentTime, @finishBakingTime, @cooldown))
  {
    msg('The oven gives a satisfying ding!')
    console(player().' has successfully found fresh bread in the oven at '.@location.'\n'
            . 'Current World Time: '.@currentTime.'\n'
            . 'Oven will be done baking on: '.@finishBakingTime)
    _bake(@location, @currentTime, @cooldown)
  }
  #If a day passed and no one claimed...
  else if (_isLeftOverBatch(@currentTime, @finishBakingTime, @cooldown))
  {
    msg('Looks like there\'s something in the oven...')
    console(player().' has successfully found leftover bread in the oven at '.@location.'\n'
            . 'Current World Time: '.@currentTime.'\n'
            . 'Oven will be done baking on: '.@finishBakingTime)
    _bake(@location, @currentTime, @cooldown)
  }
  else
  {
    _notDoneBaking(@location, @currentTime, @finishBakingTime)
  }
}

/**
 * Displays message to the player and console that
 * the oven isn't done baking
 * Usage: _notDoneBaking(@location, @currentTime, @finishBakingTime)
 */
proc(_notDoneBaking, @location, @currentTime, @finishBakingTime)
{
  msg('Looks like it\'s still baking...');
  console('The oven at '.@location.' is still under cooldown\n'
          . 'Current World Time: '.@currentTime.'\n'
          . 'Oven will be done baking on: '.@finishBakingTime)
}

/**
 *  Complete baking whatever's in the oven
 *  Usage: _bake(@location, @currentTime, @cooldown)
 */
proc(_bake, @location, @currentTime, @cooldown)
{
  _fillOven(@location)
  
  #Update time that the oven was last filled! VERY IMPORTANT
  @scNextBatch = @currentTime + @cooldown;
  if(@scNextBatch > 24000, @scNextBatch = @scNextBatch - 24000)
  store_value('cooldowns.'.@location.'.cafe.oven', @scNextBatch);
}

/**
 *  Shows the logic messages whether the oven should be filling or not
 *  Usage: _debugCafeOvenFillerLogic(@finishBakingTime, @cooldown, @currentTime)
 */

proc(_debugCafeOvenFillerLogic, @finishBakingTime, @cooldown, @currentTime)
{
    if(@finishBakingTime < @cooldown)
    {
      @startBakingTime = (@finishBakingTime + 24000) - @cooldown
      @nextDay = true
    }
    else
    {
      @startBakingTime = @finishBakingTime - @cooldown
      @nextDay = false
    }

    msg('Start Baking Time: '.@startBakingTime.'        Finish Baking Time: '.@finishBakingTime)
    msg('Is it the next day? '.@nextDay.'        Current Time: '.@currentTime)
    msg('\nIs the current batch that was put in earlier done baking? \n' . _isDoneBakingBatch(@currentTime, @finishBakingTime, @cooldown))
    msg('\nAre there any leftovers from yesterday? \n' . _isLeftOverBatch(@currentTime, @finishBakingTime, @cooldown))
}