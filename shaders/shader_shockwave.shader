attribute vec3 in_Position; 
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_pos;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_pos = gm_Matrices[MATRIX_WORLD] * object_space_pos;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
uniform sampler2D tex_back;
uniform vec2 one_div_screen_res;
uniform vec2 screen_pos;
uniform float shock_magnitude;

varying vec2 v_vTexcoord;
varying vec4 v_pos;
varying vec4 v_vColour;

void main()
{
    //read displacement map
    vec2 displace = 2.0*(texture2D( gm_BaseTexture, v_vTexcoord.xy ).xy-0.5);
    
    //compute displacement coordinates (scale by shock_magnitude and image_alpha)
    vec2 new_tex_coord = (v_pos.xy - screen_pos  + displace * shock_magnitude * v_vColour.a) * one_div_screen_res;

    //return new color
    gl_FragColor = texture2D(tex_back,new_tex_coord);
}

