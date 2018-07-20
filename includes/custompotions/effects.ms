/**
 * Removes negative status effects from specified player
 */
proc(_removeNegativeEffects, @player)
{
  #List the ids of all the negative status effects available. 
  @negativeEffects = array(
                            2,  #slowness
                            4,  #mining fatigue
                            9,  #nausea
                            15, #blindness
                            17, #hunger
                            18, #weakness
                            19, #poison
                            20  #wither
                          )
                          
  @current_peffects = get_peffect(@player);
  foreach(@negativeEffect in @negativeEffects)
  {
    foreach(@effect in @current_peffects)
    {
      if(@effect[id] == @negativeEffect)
      {
        set_peffect(@player, @effect[id], 1, 0);
      }
    }
  }
}