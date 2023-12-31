#version 430 core

const vec4 ground_color = vec4(1.0, 1.0, 1.0, 1.0);
const vec4 octahedron_color = vec4(1,0,0,1);
const vec4 link_color = vec4(0,1,0,1);
const vec4 box_color = vec4(0,0,1,1);

float color_intensity = 1.0;
vec3 diffuse_color = vec3(1.0, 1.0, 1.0);

// include common/define.fs
// include common/math.fs
// include common/sdf.fs
// include common/operations.fs
// include common/colors/colors_scene1.fs
// include common/colors/colors_raymarch.fs
// include common/colors/colors_normal.fs
// include common/colors/colors_lights.fs

void main(){

  vec2 u_resolution = vec2(screen_width, screen_height);
  vec2 uv = (gl_FragCoord.xy-.5*u_resolution.xy)/u_resolution.y;

  // camera
  vec3 ro = camera;

  // ray direction
  vec3 rd = normalize(vec3(uv.x,uv.y,1.0));

  // distance
  float d = ray_march(ro,rd,diffuse_color);

  vec3 p = ro + rd * d;
  // Diffuse lighting
  vec3 color = get_light(p,diffuse_color);

  // Set the output color
  out_color = vec4(color,1.0);
}
