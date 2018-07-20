proc(_hasItem, @player)
{
	@inventory = pinv(@player)
	@ticketSlot = -1
	foreach(@slot: @item in @inventory)
	{
		if(_isItem(@item))
		{
			@ticketSlot = @slot
			break()
		}
	}
	return(@ticketSlot)
}

proc(_isItem, @item)
{
	if(@item != null && @item[meta] != null && @item[meta][display] == 'Morpheus\' Poppy' && @item[meta][lore] == array('One of the many poppies', 'growing in Morpheus\' cave') && @item[name] == 'RED_ROSE' && @item[enchants] == array(array(elevel: 10, etype: 'LURE')))
	{
		return(true)
	}
	else
	{
		return(false)
	}
}

proc(_takeItem, @player, @slot)
{
	@inventory = pinv(@player)
	@ticket = @inventory[@slot]
	if(@ticket[qty] == 1)
	{
		@ticket = null
	}
	else
	{
		@ticket[qty] = @ticket[qty] - 1
	}
	@inventory[@slot] = @ticket
	set_pinv(@player, @inventory)
}