/// array_to_string(array)

var input = argument0;
var output = "";

if(!is_array(input))
{
    return "INPUT NOT ARRAY";
}

for (i = 0; i < array_length_1d(input); i++)
{
    output += string(input[i]);
}

return output;
