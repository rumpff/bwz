/// wave(peak (f), time (f), smooth (b))

/* 
 * - Waves a value from 0 to peak -
 * peak (f) - peak value in the wave
 * time (f) - current time in the wave [0 - 1] 
 * smooth (b) - if the wave starts and ends smooth
*/

var _peak = argument0;
var _time = argument1;
var _smooth = argument2;

var _output = 0;
var _dir = sign(_peak);

var _r = clamp(_time, 0, 1);

if(_smooth)
{
    _r *= (pi * 2);
}
else
{
    _r *= pi;
}

_r += pi;

if(_smooth)
{
    _output = cos(_r) * 0.5;
    _output += 0.5;
}
else
{
    _output = cos(_r + (pi * 0.5));
}


_output *= _peak;
  
return _output;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

//var output = (((cos(_r) * 0.5 + 0.5)) * _peak) * _dir + _start;
//return output;
