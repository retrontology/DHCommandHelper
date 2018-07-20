proc(_convertToTime, @milliseconds)
{
    @seconds = _convertToSeconds(@milliseconds)
    @minutes = _convertToMinutes(@seconds[toMinutes])
    @hours = _convertToHours(@minutes[toHours])
    
    @time = @hours[toDays].'h '
    @time .= @hours[minutes].'m '
    @time .= @minutes[seconds].'s '
    
    @fullTime = array(
                      time: @time,
                      inHours: @hours[toDays],
                      inMinutes: @minutes[toHours],
                      inSeconds: @seconds[toMinutes]
                      )
    
    return(@fullTime)
}

proc(_convertToSeconds, @milliseconds)
{
  @remainder = @milliseconds%1000
  @seconds = (@milliseconds - @remainder)/1000
  
  @results = array(toMinutes: @seconds, seconds: @remainder)
  return(@results)
}

proc(_convertToMinutes, @seconds)
{
    @remainder = @seconds%60
    @minutes = (@seconds - @remainder)/60
    @results = array(toHours: @minutes, seconds: @remainder)
    return(@results)
}

proc(_convertToHours, @minutes)
{
    @remainder = @minutes%60
    @hours = (@minutes - @remainder)/60
    
    @results = array(toDays: @hours, minutes: @remainder)
    return(@results)
}

proc(_convertToDays, @hours)
{
    @remainder = @hours%24
    @days = (@hours - @remainder)/24
    
    @results = array(days: @days, hours: @remainder)
    return(@results)
}