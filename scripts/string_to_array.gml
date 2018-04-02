/// string_to_array(string, size)

var input = argument0;
var size = argument1
var output;

for (i = 0; i < size; i++)
{
    if(i <= string_length(input))
    {
        output[i] = string_char_at(input, i+1);
    }
    else
    {
        output[i] = "";
    }
}

return output; 
