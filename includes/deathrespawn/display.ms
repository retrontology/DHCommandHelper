proc(_messageSequenceGrim, @player)
{
  @lines = array(
                  '&8You are now a metaphysical being...',
                  '&7\t\t...trapped within Grim\'s Lantern.',
                  '&l&o\t\t\t\t...your soul now belongs to The Reaper',
                  '&c&l---------------------------------------------',
                  '&c&lGrim: I do not want you here... Make a Choice',
                  '&c&l---------------------------------------------',
                  '&8&oNote: Right click the sign of your choice.',
                  ' ',
                  '&l\tRevertere Ad Sanctuarium',
                  '&8&o\t\t(Return to Sanctuary)',
                  '\t\tI will return you back to Sanctuary',
                  '\t\tand you will once again be human.\n\n',
                  ' ',
                  '&l\tAd Tuos Penates',
                  '&8&o\t\t(Return to Your Hearth)',
                  '\t\tAt the cost of 100 claimblocks',
                  '\t\tYou will be returned to the place of your hearth;',
                  '\t\thowever, you will only be half alive.',
                  ' '
              )
  
  @timeout = 0
  foreach(@line in @lines)
  {
    set_timeout(@timeout, closure(){
      tmsg(@player, colorize(@line))
    })
    @timeout = @timeout + 500
  }
}