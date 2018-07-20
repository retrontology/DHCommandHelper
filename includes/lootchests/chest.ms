/*
 * Fill the chest specified. 
 * Usage: _fillChest(@chest)
 */
proc(_fillChest, @chest)
{
  #Declare some "constants"
  @slotItemChance = 0           #Chance that an item will appear on this slot
  @maxItemsPerChest = 0         #Max amount of unique items that will appear in the chest
  @minChestSlot = 1             #Usually is 1.
  @maxChestSlot = get_inventory_size(@chest)            
  @itemPool = _setItemPool(@arena)
  
  for(@i=@minChestSlot, @i<=@maxChestSlot, @i++) 
  {
    #Decides by random chance whether the slot in the chest will contain an item or not. 
    if(rand(1,100) <= @slotItemChance)
    {
      #Picks a random item to add from the @itemPool
      @selectedItem = array_rand(@itemPool)
      
      #Determine random quantity
      @itemQty = rand(1,@selectedItem[maxQty])
      
      #Package item & put it in a chest slot
      @packagedItem = array(type:@selectedItem[id], qty:@itemQty)
      set_inventory(@chest[location], @packagedItem)
    }
  }
}

/*
 * Returns true when block supplied is a chest
 * Usage: _isChest(@chestLocation)
 */
proc(_isChest, @chestLocation) 
{
  @isChest = false
  @block = get_block_at(@chestLocation)
  switch(@block)
  {
    case '54:2':
    case '54:3':
    case '54:4':
    case '54:5':
      @isChest = true
      break;
    default:
      @isChest = false
  }
  return(@isChest)
}

/*
 * Returns a boolean. Checks if chest that belongs to the arena is empty. 
 */
proc(_isChestEmpty, @chest)
{
  @isChestEmpty = true;
  @inventory = get_inventory(@chest)
  foreach(@slot in @inventory)
  {
    if(@slot != null, @isChestEmpty = false)
  }
  return(@isChestEmpty)
}

/*
 * Returns true if the chest is in a world 
 * where chests that are empty are suppose 
 * to disappear
 */
proc(_isChestInRightWorld, @chest)
{
  switch(@chest[world])
  {
    case 'Arena':
      @isChestInRightWorld = true
      break
    case 'Tartaros':
      @isChestInRightWorld = true
      break
    case 'Parkour':
      @isChestInRightWorld = true
      break
    default:
      @isChestInRightWorld = false
  }
  return(@isChestInRightWorld)
}
