/// input_timers_active(i)

var output;

if(floor(m_inputTimer[0]) == 0)
{
    output = true;
    
    var newTime = (m_inputTimerCurrent[0] * 0.6)   
         
    if(newTime >= m_inputTimerMin) 
    { m_inputTimerCurrent[0] = newTime; }
    else { m_inputTimerCurrent[0] = m_inputTimerMin }
    
    m_inputTimer[0] = m_inputTimerCurrent[0];       
}
else
{
    output = false;
    m_inputTimer[0]--;
}

return output;
