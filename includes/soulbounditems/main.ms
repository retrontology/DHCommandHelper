@destroyOnDropItems = array(
                            array(type: 426,
                                  name: 'END_CRYSTAL',
                                  meta: array(
                                          display: 'Join Clan Token',
                                          lore: array('Allows a player to randomly join, a recruiting clan., Right-click to use.')
                                        )
                                  )
                      )
export('soulbounditems', @destroyOnDropItems)

proc(_isSoulBound, @item)
{
  @destroyOnDropItems = import('soulbounditems')
  foreach(@soulboundItem in @destroyOnDropItems)
  {
    if(_sameItem(@soulboundItem, @item), return(true))
  }
  return(false)
}

proc(_getItem, @index)
{
  @destroyOnDropItems = import('soulbounditems')
  return(@destroyOnDropItems[@index])
}

proc(_sameItem, @item1, @item2)
{
  #msg(@item1[name]." = ".@item2[name])
  if(@item1[name] != @item2[name], return(false))

  #msg(@item1[type]." = ".@item2[type])
  if(@item1[type] != @item2[type], return(false))

  #msg(@item1[meta] .'\n'. @item2[meta])
  if(@item1[meta] != @item2[meta], return(false))
  
  #msg(@item1[meta][display] .'\n'. @item2[meta][display])
  if(@item1[meta][display] != @item2[meta][display], return(false))

  #msg(@item1[meta][lore] ."\n". @item2[meta][lore])
  if(@item1[meta][lore] != @item2[meta][lore], return(false))
  
  return(true)
}