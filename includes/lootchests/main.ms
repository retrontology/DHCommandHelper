include('chest.ms')
include('itempool.ms')
include('patterns.ms')

/*
 *  Spawns chests in a specified arena containing random items.
 */
proc(_lootchests)
{
  @pattern = _selectPattern(@arena)
  foreach(@chest in @pattern)
  {
    _fillChest(@chest)
  }
}

/*
 * Removes chest at specified location
 * given that it fulfils the criteria
 */
proc(_removeArenaChest, @chestLocation)
{
  export('chest.location', @chestLocation)
  console('Removing chest at ' . @chestLocation)

  if(has_bind('inventory_close-arena') != true)
  {
    #msg('Currently unbound')
    bind(inventory_close, array(id: 'inventory_close-arena'), null, @event,
      @currentChest = import('chest.location')
      if(_shouldRemoveChest(@currentChest) && get_block_at(@currentChest) != 0)
      {
        console('Chest Removed at ' . @currentChest)
        set_block_at(@currentChest, 0)
      }
      @currentChest = null
      unbind()
    )
  }  
}

/*
 * Returns true if chest should be removed.
 */
proc(_shouldRemoveChest, @chestLocation)
{
  if(_isChest(@chestLocation)
      && _isChestInRightWorld(@chestLocation)
      && _isChestEmpty(@chestLocation)
      #&& (player() == 'AceyXx' || player() == 'Gokuh') #Restricts action to acey and jck for testing
    )
  {
    return(true)
  }
  return(false)
}