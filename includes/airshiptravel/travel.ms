proc(_travel, @player, @destination)
{
	@tp = array()
	#array(0:, 1:, 2:, 3:'', world:'', x:, y:, z:, name:'', subtitle:'', direction:)
	@ships = array(
					array(0:130.5, 1:178, 2:25.5, 3:'Sanctuary', world:'Sanctuary', x:130.5, y:178, z:25.572, 
					name:'Sanctuary', subtitle:'Haven from the war', direction:0),
					array(0:859.5, 1:89, 2:-965.5, 3:'Marshacre', world:'Marshacre', x:859.5, y:89, z:-965.5, 
					name:'Marshacre', subtitle:'Consequenceless PvP Arena', direction:3),
					array(0:128.5, 1:126, 2:19.5, 3:'Hammerlea', world:'Hammerlea', x:128.5, y:126, z:19.5, 
					name:'Hammerlea', subtitle:'The New World', direction:3)
				  )
				  
	foreach(@ship in @ships)
	{
		if(@ship[name] == @destination)
		{
			@tp = @ship
			break()
		}
	}
	
	set_ploc(@player, @tp)
	pfacing(@player, @tp[direction])
	
	runas('~console', '/tm msg '.@player.' &a~'.@tp[name].'~<nl>'.@tp[subtitle])
}