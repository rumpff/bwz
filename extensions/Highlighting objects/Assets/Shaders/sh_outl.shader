//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 colour;
uniform vec2 size;
uniform sampler2D tex;
uniform vec2 tex_size;

float get_r( vec2 coord )
{
    return min( texture2D( gm_BaseTexture, v_vTexcoord + coord*size ).r, texture2D( gm_BaseTexture, v_vTexcoord - coord*size ).r );
}

// outline
float dif ()
{
    float val;
    float i;
    i=0.0;
    val=1.0;
    
    
    val=min( get_r( vec2( sin(i), cos(i) ) ), val );
    i+=0.52; //pi/6 - 180/6
    
    val=min( get_r( vec2( sin(i), cos(i) ) ), val );
    i+=0.52;
    
    val=min( get_r( vec2( sin(i), cos(i) ) ), val );
    i+=0.52;
    
    val=min( get_r( vec2( sin(i), cos(i) ) ), val );
    i+=0.52;
    
    val=min( get_r( vec2( sin(i), cos(i) ) ), val );
    i+=0.52;
    
    val=min( get_r( vec2( sin(i), cos(i) ) ), val );
    
    
    return 1.0-val*1000.0;
}

void main()
{
    gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord );
    // get colour from outl_texture and surface
    gl_FragColor.a = gl_FragColor.r * texture2D( tex, vec2( fract(v_vTexcoord.x * tex_size.x), fract(v_vTexcoord.y * tex_size.y) ) ).r;
    // if current pixel is outline, set alpha to 1
    gl_FragColor.a = max(gl_FragColor.a, max(dif()*gl_FragColor.r, 0.0))*gl_FragColor.g;
    gl_FragColor.rgb = colour;
}

