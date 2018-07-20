include('effects.ms')

proc(_customPotion, @name)
{
  switch(@name)
  {
    case 'Mocha':
      _removeNegativeEffects(player())
      set_peffect(player(), 1, 1, 180) #Give player Speed II for 3 minutes
      break
	case 'Slowfall':
      _removeNegativeEffects(player())
      set_peffect(player(), 25, -4, 120) #Give player Negative Levitation for 1 minute
      break
    default:
      msg('This potion doesn\'t exist')
  }
}