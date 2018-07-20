proc(_wakeUp, @player)
{
  # Remove Visuals Effects
  set_peffect(@player, 15, 1, 0)
  set_peffect(@player, 16, 1, 0)
  
  @playerHealth = pinfo(@player, 5)
  @playerHunger = phunger(@player)  
  @sleepCounter = import(_getSleepCounterKey(@player), 0)
  
  # If player has slept through the night and essentially
  # stayed in bed a lot of the night
  if(@playerHealth > 19  && @playerHunger > 10 && @sleepCounter > 2)
  {
    set_peffect(@player, 22, 0, 180)
    tmsg(@player, 'You get out of bed feeling well rested!... and hungry')
  }
  # If the player slept and got some regen effects
  else if(@playerHealth < 20 && @sleepCounter > 1)
  {
    tmsg(@player, 'You get out of bed feeling rested!')
  }
  else if(@playerHunger < 2 && @sleepCounter > 1)
  {
    tmsg(@player, 'You woke up from bed starving!')
  }
  # Every other possibility
  else
  {
    tmsg(@player, 'You\'ve gotten out of bed after a good nights\' sleep')
  }
}

proc(_canEnterBed, @player)
{
  # Get the time the player last entered a bed
  @lastEnteredBed = import(_getLastBedEntryKey(@player))
  
  # Calculate a minute
  @minute = 1 * 60 * 1000 #whole minute!
  
  # Ensure that last entered bed isn't null. 
  # This can occur when a player has never 
  # entered a bed in Dragonhollow before. (new player)
  if(@lastEnteredBed == null)
  {
    @lastEnteredBed = time() - (@minute * 2)
  }
  
  # Set when a player can enter a bed again. 
  @canEnterAgain = @lastEnteredBed + @minute
  
  # Log some console messages for information
  console('\n\t[BedREGEN] '.@player.' entered a bed at \n\t--'.simple_date('MM/dd/yy hh:mm:ss', time()))
  
  @world = ploc(@player)[world]
  
  if(@world = 'Sanctuary', return(true))
  
  if(@canEnterAgain > time())
  {
    return(false) # Cooldown not ready
  }
  return(true) # Cooldown over
}

proc(_doSleepCycle, @player)
{
	x_new_thread('bedregen.'.@player, closure(){
	  export(_getLastBedEntryKey(@player), time())
	  set_timeout(30000, closure(){
		#Message to player
		if(pinfo(@player, 16))
		{
		  tmsg(@player, color(l).color(o).'You are falling asleep, Goodnight!')
		  @friendlyMsg = "You're about to enter a really boring time staring at a black screen. "
		  @friendlyMsg .= "Now might be a good time to stretch your legs and maybe get some water."
		  tmsg(@player, @friendlyMsg)
		}
		_sleepCycle(@player)
	  })
	})
}

proc(_sleepCycle, @player)
{
  set_interval(30000, closure(){
    if(!ponline(@player) || !pinfo(@player, 16))
    {
      die()
    }
    if(pinfo(@player, 16))
    {
      _sleepEffects(@player)
    }
  })
}

proc(_sleepEffects, @player)
{
  # Get all variables needed
  @playerHealth = pinfo(@player, 5)
  @playerHunger = phunger(@player)
  @sleepCounter = import(_getSleepCounterKey(@player), 0)

  # Console Messages
  console('\n\t[BedREGEN] '.@player.' has fallen asleep during '.simple_date('MM/dd/yy hh:mm:ss', time()))
  console('\n\t[BedREGEN] Player Health: '.@playerHealth)
  console('\n\t[BedREGEN] Player Hunger: '.@playerHunger)
  console('\n\t[BedREGEN] Sleep Counter: '.@sleepCounter)
  
  # Cancel the player_enter_bed event which hopefully should kick them out of bed if they're starving
  if(@playerHunger < 3 && @sleepCounter > 1)
  {
    cancel()
  }
  # Increase health OR hunger
  else if(@playerHealth < 20)
  {
    # Regen Health
    _regenHealth(@player)
  }
  else if(@playerHealth == 20 && @playerHunger < 15)
  {
    # Regen Hunger
    _regenHunger(@player)
  }
  
  # Increase Sleep Counter
  @sleepCounter++
  export(_getSleepCounterKey(@player), @sleepCounter)
}

proc(_regenHealth, @player)
{
  # Create Visual Effects for Sleeping in a Bed
  set_peffect(@player, 15, 1, 33, false, false)
  set_peffect(@player, 16, 1, 33, false, false)
  make_effect(ploc(), 'HAPPY_VILLAGER', 2)
  
  # Send Console Messages
  console('\n\t[BedREGEN] '.@player.' is at less than full health!.... Healing')
  
  # Create Regen Effect
  _increaseHealth(@player)
  _decreaseHunger(@player)
}

proc(_regenHunger, @player)
{
  # Create Visual Effects for Sleeping in a Bed
  set_peffect(@player, 15, 1, 33, false, false)
  
  # Send Console Messages
  console('\n\t[BedREGEN] '.@player.' is at full health and still resting in bed! ...Feeding')
  
  # Create Regen Effect
  _increaseHunger(@player)
}

proc(_increaseHealth, @player)
{
  @playerHealth = pinfo(@player, 5)
  @playerHealth++
  if(@playerHealth < 20.0)
  {
    set_phealth(@player, @playerHealth)
  }
  else
  {
    set_phealth(@player, 20)
  }
}

proc(_decreaseHunger, @player)
{
  @playerHunger = phunger(@player)
  @playerHunger = @playerHunger - 2
  set_phunger(@player, @playerHunger)
}

proc(_increaseHunger, @player)
{
  @playerHunger = phunger(@player)
  @playerHunger++
  set_phunger(@player, @playerHunger)
}

proc(_getSleepCounterKey, @player)
{
  return('bedREGEN.sleepcounter.'.@player)
}

proc(_getLastBedEntryKey, @player)
{
  return('bedREGEN.last_bed_entry.'.@player)
}