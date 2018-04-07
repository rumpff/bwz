attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_texcoord;
varying vec4 v_color;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_color = in_Colour;
    v_texcoord = in_TextureCoord;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_texcoord;
varying vec4 v_color;

uniform float displacement;

void main()
{
    vec2 uv = v_texcoord.xy;
    vec4 tex_color;
    tex_color.r = texture2D(gm_BaseTexture, vec2(uv.x + displacement, uv.y)).x;
    tex_color.g = texture2D(gm_BaseTexture, vec2(uv.x, uv.y)).y;
    tex_color.b = texture2D(gm_BaseTexture, vec2(uv.x - displacement, uv.y)).z;
    tex_color.a = texture2D(gm_BaseTexture, vec2(uv.x, uv.y)).a;
    gl_FragColor.rgba = tex_color;
}

