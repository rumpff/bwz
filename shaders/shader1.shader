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

//######################_==_YOYO_SHADER_MARKER_==_######################@~
#in coloremulation

uniform sampler2D source[];

in Vertex {
  vec2 texCoord;
};

out vec4 fragColor;

void main() {
  vec4 rgba = texture(source[0], texCoord);
  #ifndef coloremulation
  fragColor = rgba;
  #else
  float r = rgba[0];
  float g = rgba[1];
  float b = rgba[2];
  fragColor = vec4(
    min(r * 806 + g * 124 + b *  62, 960.0) / 1023.0,
    min(          g * 744 + b * 248, 960.0) / 1023.0,
    min(r * 186 + g * 124 + b * 682, 960.0) / 1023.0,
    0.0
  );
  #endif
}
