/**
 *  SCROLL LIST
 */
@scrolls = array(
                  Sanctuary:array(type: 339,
                                  name: 'PAPER',
                                  meta: array(
                                          display: 'Sanctuary Teleport Scroll',
                                          lore: array('Right click to teleport, to Sanctuary'), 
                                          enchants: array(array(elevel: 10, etype: DIG_SPEED)),
                                        ),
                                  location: 'Sanctuary'
                                  ),
					Leingenwood:array(type: 339,
                                  name: 'PAPER',
                                  meta: array(
                                          display: 'Leingenwood Teleport Scroll',
                                          lore: array('Right click to teleport, to Leingenwood Race Track'), 
                                          enchants: array(array(elevel: 10, etype: DIG_SPEED)),
                                        ),
                                  location: 'Leingenwood'
                                  )
					Marshacre:array(type: 339,
                                  name: 'PAPER',
                                  meta: array(
                                          display: 'Marshacre Teleport Scroll',
                                          lore: array('Right click to teleport, to Marshacre'), 
                                          enchants: array(array(elevel: 10, etype: DIG_SPEED)),
                                        ),
                                  location: 'Marshacre'
                                  ),
					Hammerlea:array(type: 339,
                                  name: 'PAPER',
                                  meta: array(
                                          display: 'Hammerlea Teleport Scroll',
                                          lore: array('Right click to teleport, to Hammerlea'), 
                                          enchants: array(array(elevel: 10, etype: DIG_SPEED)),
                                        ),
                                  location: 'Sanctuary'
                                  ),
           )

@getScroll = closure()
{
  foreach(@scroll in @scrolls)
  {
    if(@arguments[0] == @scroll[location], return(@scroll))
  }
}