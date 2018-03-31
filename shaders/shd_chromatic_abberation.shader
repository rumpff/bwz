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

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 u_uSource;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main()
{

    float r1 = 0.0025;
    float r2 = r1*2.;
    float s1 = 1.-r1*2.;
    float s2 = 1.-r2*2.;
 
    float xx = v_vTexcoord.x;
    float yy = v_vTexcoord.y;
 
    vec2 point = vec2(xx - u_uSource.x, (yy - u_uSource.y)*9./16.);
    float len = length(point);
 
    float ran = 0.3*rand(vec2(u_uSource.w+xx,yy));

    if(len+ran>0.7) gl_FragColor.rgb = vec3(0.,0.,0.);
    else {
 
        vec3 newcoordx = vec3(xx,xx*s1+r1,xx*s2+r2);
        vec3 newcoordy = vec3(yy,yy*s1+r1,yy*s2+r2);
 
        gl_FragColor = vec4(0,0,0,1);
 
        gl_FragColor.r = (v_vColour * texture2D( gm_BaseTexture, vec2(newcoordx.r, newcoordy.r))).r;
        gl_FragColor.g = (v_vColour * texture2D( gm_BaseTexture, vec2(newcoordx.g, newcoordy.g))).g;
        gl_FragColor.b = (v_vColour * texture2D( gm_BaseTexture, vec2(newcoordx.b, newcoordy.b))).b; 
 
        if(len>u_uSource.z) gl_FragColor = 1. - gl_FragColor;
 
    } 
}
