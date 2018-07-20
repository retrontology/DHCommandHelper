include('travel.ms')

# "/airshiptravel <player> <destination>"
proc(_airshipTravel, @player, @destination)
{
	# Check for ticket
	@slot = _hasTicket(@player)
	if(@slot == -1, die(color(7).'[DH Console]'.color(e).'You require a ticket for the airship'))
	
	# Take one ticket
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
	
	# Teleport
	switch(@destination)
	{
		case 'Sanctuary':
			_travel(@player, 'Sanctuary')
			break()
		case 'Marshacre':
			_travel(@player, 'Marshacre')
			break()
		case 'Hammerlea':
			_travel(@player, 'Hammerlea')
			break()
		default:
			tmsg(@player, 'The specified destination is not found. Tell Retro he fukt up')
	}
}

proc(_hasTicket, @player)
{
	@inventory = pinv(@player)
	@ticketSlot = -1
	foreach(@slot: @item in @inventory)
	{
		if(_isTicket(@item))
		{
			@ticketSlot = @slot
			break()
		}
	}
	return(@ticketSlot)
}

proc(_isTicket, @item)
{
	if(@item != null && @item[meta] != null && @item[meta][display] == 'Airship Ticket' && @item[meta][lore] == array('Grants one ride on the airship!') && @item[type] == '339')
	{
		return(true)
	}
	else
	{
		return(false)
	}
}