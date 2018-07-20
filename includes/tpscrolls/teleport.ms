/**
 * Teleports Player to specified town listed in the array
 * This function is specifically made for the teleport scrolls
 * Usage: _teleport(@player, @location)
 */
proc(_teleport, @player, @location)
{
  @towns = array(
                  array(0:8.5, 1:140.5, 2:8.5, 3:'Sanctuary', world:'Sanctuary', x:8.5, y:140.5, z:8.5, name:'Sanctuary', subtitle:'Haven from the War', direction:0),
                  array(0:8.5, 1:86, 2:8.5, 3:'Hammerlea', world:'Hammerlea', x:8.5, y:86, z:8.5, name:'Hammerlea', subtitle:'The New World', direction:0),
				  array(0:859.5, 1:89, 2:-965.5, 3:'Marshacre', world:'Marshacre', x:859.5, y:89, z:-965.5, name:'Marshacre', subtitle:'Consequenceless PvP Arena', direction:3),
                  array(0:-102.5, 1:15, 2:-1131.5, 3:'Dragonhollow_events', world:'Dragonhollow_events', x:-102.5, y:15, z:-1131.5, name:'Leingenwood', subtitle:'The Premier Location for Horse Racing', direction:0)
                )
                
  #Find a location match and set a tp point
  foreach(@town in @towns)
  {
    if(@town[name] == @location, @tpPoint = @town)
  }
  
  set_ploc(@player, @tpPoint);
  pfacing(@player, @tpPoint[direction]);
  
  runas('~console', '/tm msg '.@player.' &a~'.@tpPoint[name].'~<nl>'.@tpPoint[subtitle])
}