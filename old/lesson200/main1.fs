#version 430 core

const vec4 ground_color   = vec4(1.0, 1.0, 1.0, 1.0);
const vec4 box_color      = vec4(1,0,0,1);
const vec4 sphere_color   = vec4(0,1,0,1);
const vec4 cylinder_color = vec4(0,0,1,1);

float color_intensity = 1.0;
vec3 diffuse_color = vec3(1.0, 1.0, 1.0);

const float PI           = 3.1415925359;
const int   MAX_STEPS    = 100;
const float MAX_DIST     = 100.0;
const float SURFACE_DIST = 0.001;

uniform vec3  camera;
uniform vec3  primary_light;
uniform int   screen_width;
uniform int   screen_height;
uniform float time;

out vec4 out_color;

float dot2( in vec2 v ) {
  return dot(v,v);
}

float dot2( in vec3 v ) {
  return dot(v,v);
}

float ndot( in vec2 a, in vec2 b ) {
  return a.x*b.x - a.y*b.y;
}

// 2D rotation matrix
mat2 rotate(float a){
  float s = sin(a);
  float c = cos(a);
  return mat2(c,-s,s,c);
}

//
// returns a transformation matrix that will transform a ray from view space
// to world coordinates, given the eye point, the camera target, and an up vector.
//
// This assumes that the center of the camera is aligned with the negative z axis in
// view space when calculating the ray marching direction.
//
mat4 view_matrix(vec3 camera, vec3 center, vec3 up) {
  vec3 f = normalize(center - camera);
  vec3 s = normalize(cross(f, up));
  vec3 u = cross(s, f);
  return mat4(
    vec4(s, 0.0),
    vec4(u, 0.0),
    vec4(-f, 0.0),
    vec4(0.0, 0.0, 0.0, 1)
  );
}

// sdf

float sdPlane( vec3 p ){
  return p.y;
}

float sdSphere( vec3 p, vec3 c, float s ){
  return length(p-c)-s;
}

float sdSphere( vec3 p, float s ){
  return length(p)-s;
}

float sdBox( vec3 p, vec3 b ){
  vec3 d = abs(p) - b;
  return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
}

float sdBoundingBox( vec3 p, vec3 b, float e ){
  p = abs(p)-b;
  vec3 q = abs(p+e)-e;

  return min(min(
      length(max(vec3(p.x,q.y,q.z),0.0))+min(max(p.x,max(q.y,q.z)),0.0),
      length(max(vec3(q.x,p.y,q.z),0.0))+min(max(q.x,max(p.y,q.z)),0.0)),
      length(max(vec3(q.x,q.y,p.z),0.0))+min(max(q.x,max(q.y,p.z)),0.0));
}

// approximated
float sdEllipsoid( in vec3 p, in vec3 r ) {
  float k0 = length(p/r);
  float k1 = length(p/(r*r));
  return k0*(k0-1.0)/k1;
}

float sdTorus( vec3 p, vec2 t ){
  return length( vec2(length(p.xz)-t.x,p.y) )-t.y;
}

float sdCappedTorus(in vec3 p, in vec2 sc, in float ra, in float rb){
  p.x = abs(p.x);
  float k = (sc.y*p.x>sc.x*p.y) ? dot(p.xy,sc) : length(p.xy);
  return sqrt( dot(p,p) + ra*ra - 2.0*ra*k ) - rb;
}

float sdHexPrism( vec3 p, vec2 h ){
  vec3 q = abs(p);

  const vec3 k = vec3(-0.8660254, 0.5, 0.57735);
  p = abs(p);
  p.xy -= 2.0*min(dot(k.xy, p.xy), 0.0)*k.xy;
  vec2 d = vec2(
  length(p.xy - vec2(clamp(p.x, -k.z*h.x, k.z*h.x), h.x))*sign(p.y - h.x),p.z-h.y );
  return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}

float sdOctogonPrism( in vec3 p, in float r, float h ){
  const vec3 k = vec3(-0.9238795325,   // sqrt(2+sqrt(2))/2
                       0.3826834323,   // sqrt(2-sqrt(2))/2
                       0.4142135623 ); // sqrt(2)-1
  // reflections
  p = abs(p);
  p.xy -= 2.0*min(dot(vec2( k.x,k.y),p.xy),0.0)*vec2( k.x,k.y);
  p.xy -= 2.0*min(dot(vec2(-k.x,k.y),p.xy),0.0)*vec2(-k.x,k.y);
  // polygon side
  p.xy -= vec2(clamp(p.x, -k.z*r, k.z*r), r);
  vec2 d = vec2( length(p.xy)*sign(p.y), p.z-h );
  return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}

float sdCapsule( vec3 p, vec3 a, vec3 b, float r ){
  vec3 pa = p-a, ba = b-a;
  float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
  return length( pa - ba*h ) - r;
}

float sdRoundCone( in vec3 p, in float r1, float r2, float h ){
  vec2 q = vec2( length(p.xz), p.y );

  float b = (r1-r2)/h;
  float a = sqrt(1.0-b*b);
  float k = dot(q,vec2(-b,a));

  if( k < 0.0 ) return length(q) - r1;
  if( k > a*h ) return length(q-vec2(0.0,h)) - r2;

  return dot(q, vec2(a,b) ) - r1;
}

float sdRoundCone(vec3 p, vec3 a, vec3 b, float r1, float r2){
  // sampling independent computations (only depend on shape)
  vec3  ba = b - a;
  float l2 = dot(ba,ba);
  float rr = r1 - r2;
  float a2 = l2 - rr*rr;
  float il2 = 1.0/l2;

  // sampling dependant computations
  vec3 pa = p - a;
  float y = dot(pa,ba);
  float z = y - l2;
  float x2 = dot2( pa*l2 - ba*y );
  float y2 = y*y*l2;
  float z2 = z*z*l2;

  // single square root!
  float k = sign(rr)*rr*rr*x2;
  if( sign(z)*a2*z2 > k ) return  sqrt(x2 + z2)        *il2 - r2;
  if( sign(y)*a2*y2 < k ) return  sqrt(x2 + y2)        *il2 - r1;
  return (sqrt(x2*a2*il2)+y*rr)*il2 - r1;
}

float sdTriPrism( vec3 p, vec2 h ){
  const float k = sqrt(3.0);
  h.x *= 0.5*k;
  p.xy /= h.x;
  p.x = abs(p.x) - 1.0;
  p.y = p.y + 1.0/k;
  if( p.x+k*p.y>0.0 ) p.xy=vec2(p.x-k*p.y,-k*p.x-p.y)/2.0;

  p.x -= clamp( p.x, -2.0, 0.0 );
  float d1 = length(p.xy)*sign(-p.y)*h.x;
  float d2 = abs(p.z)-h.y;
  return length(max(vec2(d1,d2),0.0)) + min(max(d1,d2), 0.);
}

// vertical
float sdCylinder( vec3 p, vec2 h ){
  vec2 d = abs(vec2(length(p.xz),p.y)) - h;
  return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}

// arbitrary orientation
float sdCylinder(vec3 p, vec3 a, vec3 b, float r){
  vec3 pa = p - a;
  vec3 ba = b - a;
  float baba = dot(ba,ba);
  float paba = dot(pa,ba);

  float x = length(pa*baba-ba*paba) - r*baba;
  float y = abs(paba-baba*0.5)-baba*0.5;
  float x2 = x*x;
  float y2 = y*y*baba;
  float d = (max(x,y)<0.0)?-min(x2,y2):(((x>0.0)?x2:0.0)+((y>0.0)?y2:0.0));
  return sign(d)*sqrt(abs(d))/baba;
}

// vertical
float sdCone( in vec3 p, in vec2 c, float h ){
  vec2 q = h*vec2(c.x,-c.y)/c.y;
  vec2 w = vec2( length(p.xz), p.y );

  vec2 a = w - q*clamp( dot(w,q)/dot(q,q), 0.0, 1.0 );
  vec2 b = w - q*vec2( clamp( w.x/q.x, 0.0, 1.0 ), 1.0 );
  float k = sign( q.y );
  float d = min(dot( a, a ),dot(b, b));
  float s = max( k*(w.x*q.y-w.y*q.x),k*(w.y-q.y)  );
  return sqrt(d)*sign(s);
}

float sdCappedCone( in vec3 p, in float h, in float r1, in float r2 ){
  vec2 q = vec2( length(p.xz), p.y );

  vec2 k1 = vec2(r2,h);
  vec2 k2 = vec2(r2-r1,2.0*h);
  vec2 ca = vec2(q.x-min(q.x,(q.y < 0.0)?r1:r2), abs(q.y)-h);
  vec2 cb = q - k1 + k2*clamp( dot(k1-q,k2)/dot2(k2), 0.0, 1.0 );
  float s = (cb.x < 0.0 && ca.y < 0.0) ? -1.0 : 1.0;
  return s*sqrt( min(dot2(ca),dot2(cb)) );
}

float sdCappedCone(vec3 p, vec3 a, vec3 b, float ra, float rb){
  float rba  = rb-ra;
  float baba = dot(b-a,b-a);
  float papa = dot(p-a,p-a);
  float paba = dot(p-a,b-a)/baba;

  float x = sqrt( papa - paba*paba*baba );

  float cax = max(0.0,x-((paba<0.5)?ra:rb));
  float cay = abs(paba-0.5)-0.5;

  float k = rba*rba + baba;
  float f = clamp( (rba*(x-ra)+paba*baba)/k, 0.0, 1.0 );

  float cbx = x-ra - f*rba;
  float cby = paba - f;

  float s = (cbx < 0.0 && cay < 0.0) ? -1.0 : 1.0;

  return s*sqrt( min(cax*cax + cay*cay*baba, cbx*cbx + cby*cby*baba) );
}

// c is the sin/cos of the desired cone angle
float sdSolidAngle(vec3 pos, vec2 c, float ra){
  vec2 p = vec2( length(pos.xz), pos.y );
  float l = length(p) - ra;
  float m = length(p - c*clamp(dot(p,c),0.0,ra) );
  return max(l,m*sign(c.y*p.x-c.x*p.y));
}

float sdOctahedron(vec3 p,float s) {
  p=abs(p);
  float m=p.x+p.y+p.z-s;
  vec3 q;
  if(3.*p.x<m)q=p.xyz;
  else if(3.*p.y<m)q=p.yzx;
  else if(3.*p.z<m)q=p.zxy;
  else return m*.57735027;

  float k=clamp(.5*(q.z-q.y+s),0.,s);
  return length(vec3(q.x,q.y-s+k,q.z-k));
}

float sdPyramid( in vec3 p, in float h ){
  float m2 = h*h + 0.25;

  // symmetry
  p.xz = abs(p.xz);
  p.xz = (p.z>p.x) ? p.zx : p.xz;
  p.xz -= 0.5;

  // project into face plane (2D)
  vec3 q = vec3( p.z, h*p.y - 0.5*p.x, h*p.x + 0.5*p.y);

  float s = max(-q.x,0.0);
  float t = clamp( (q.y-0.5*p.z)/(m2+0.25), 0.0, 1.0 );

  float a = m2*(q.x+s)*(q.x+s) + q.y*q.y;
  float b = m2*(q.x+0.5*t)*(q.x+0.5*t) + (q.y-m2*t)*(q.y-m2*t);

  float d2 = min(q.y,-q.x*m2-q.y*0.5) > 0.0 ? 0.0 : min(a,b);

  // recover 3D and scale, and add sign
  return sqrt( (d2+q.z*q.z)/m2 ) * sign(max(q.z,-p.y));;
}

// la,lb=semi axis, h=height, ra=corner
float sdRhombus(vec3 p, float la, float lb, float h, float ra){
  p = abs(p);
  vec2 b = vec2(la,lb);
  float f = clamp( (ndot(b,b-2.0*p.xz))/dot(b,b), -1.0, 1.0 );
  vec2 q = vec2(length(p.xz-0.5*b*vec2(1.0-f,1.0+f))*sign(p.x*b.y+p.z*b.x-b.x*b.y)-ra, p.y-h);
  return min(max(q.x,q.y),0.0) + length(max(q,0.0));
}

// Link - exact
float sdLink(vec3 p,float le,float r1,float r2) {

  vec3 q = vec3(p.x,max(abs(p.y) - le,0.0),p.z);
  return length(vec2(length(q.xy) - r1,q.z)) - r2;
}

// capped cylinder
float sdCappedCylinder( vec3 p, float h, float r ) {
  vec2 d = abs(vec2(length(p.xz),p.y)) - vec2(r,h);
  return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}

// Round Box - exact
float sdRoundBox(vec3 p,vec3 b,float r) {
  vec3 q=abs(p)-b;
  return length(max(q,0.))+min(max(q.x,max(q.y,q.z)),0.)-r;
}

// Plane given a normal
float sdPlaneNormal(vec3 p,vec4 n) {
  // n must be normalized
  return dot(p,n.xyz)+n.w;
}


float smooth_minimum(float a, float b, float k){

  float h = clamp( 0.5 + 0.5 * (b - a)/k, 0.0, 1.0);
  return mix( b, a, h) - k * h * (1.0 - h);
}

//
// Boolean Operators
//
vec4 sdf_intersect(vec4 a, vec4 b) {
  return a.w > b.w ? a : b;
}

vec4 sdf_union(vec4 a, vec4 b) {
  return a.w < b.w ? a : b;
}

vec4 sdf_difference(vec4 a, vec4 b) {
  return a.w > -b.w ? a : vec4(b.rgb,-b.w);
}

vec4 get_distance(vec3 p){
  // rotate the whole scene
  p.xz *= rotate(time * 0.5);

  // Box
  vec3 b0s = vec3(.75,.75,.75);
  vec3 b0p = vec3(0,1,0);
  b0p      = p - b0p;
  vec4 b0  = vec4(box_color.rgb,sdBox(b0p,b0s));

  // Sphere
  vec3 s0p = vec3(0,1,0);
  s0p = p - s0p;
  vec4 s0 = vec4(sphere_color.rgb,sdSphere(s0p,1.05));

  // Cylinders
  float c0h = 1.0;
  float c0r = 0.55;
  vec3 c0p  = p - vec3(0,1,0);
  vec4 c0   = vec4(cylinder_color.rgb,sdCappedCylinder(c0p,c0h,c0r));

  float c1h = 1.0 , c1r = 0.55;
  vec3 c1p  = p - vec3(0,1,0);
  c1p.xy   *= rotate(PI * 0.5);
  vec4 c1   = vec4(cylinder_color.rgb,sdCappedCylinder(c1p,c1h,c1r));

  float c2h = 1.0 , c2r = 0.55;
  vec3 c2p  = p - vec3(0,1,0);
  c2p.xy   *= rotate(PI * 0.5);
  c2p.yz   *= rotate(PI * 0.5);
  vec4 c2   = vec4(cylinder_color.rgb,sdCappedCylinder(c2p,c2h,c2r));

  // Plane
  vec4 p0 = vec4(ground_color.rgb,sdPlaneNormal(p,vec4(0,1,0,0)));

  vec4 scene = vec4(0), csg0 = vec4(0), csg1 = vec4(0);

  // Intersect box with sphere creating a CSG object.
  csg0 = sdf_intersect(b0,s0);
  csg1 = sdf_union(c0,c1);
  csg1 = sdf_union(csg1,c2);

  // Subtract cylinders from boxsphere
  csg0 = sdf_difference(csg0,csg1);

  // Use Union(min) on the CSG and the ground plane
  scene = sdf_union(csg0,p0);

  //scene = vec4(1,0,1,0.5);
  return scene;
}

float ray_march(in vec3 ro, in vec3 rd, inout vec3 diff_color){

  float dzero = 0.0;
  vec4  ds    = vec4(0.0);
  vec3  p     = vec3(0.0,0.0,0.0);

  for(int i = 0; i < MAX_STEPS; i++){

    p     = ro + dzero * rd;
    ds    = get_distance(p);

    if( ds.w < SURFACE_DIST ){
      diff_color = ds.rgb;
      break;
    }

    if( dzero > MAX_DIST ){
      break;
    }

    dzero = dzero + ds.w;

  }

  return dzero;
}

vec3 get_normal(vec3 p){

  float d = get_distance(p).w;
  vec2  e = vec2(0.01,0);

  vec3  n = d - vec3(
    get_distance(p - e.xyy).w,
    get_distance(p - e.yxy).w,
    get_distance(p - e.yyx).w
  );

  return normalize(n);
}

vec3 get_light(vec3 p, vec3 c) {
  // Diffuse Color
  vec3 color = c.rgb * color_intensity;

  // Directional light
  vec3 light_pos = primary_light;

  // moving light
  light_pos.xz = light_pos.xz + vec2(sin(time), cos(time)) * 2.0;

  // light Vector
  vec3 l = normalize(light_pos-p);

  // Normal Vector
  vec3 n = get_normal(p);

  // Diffuse light
  float dif = dot(n,l);

  // Clamp so it doesnt go below 0
  dif = clamp(dif,0.,1.);

  // Shadows
  float d = ray_march(p + n * SURFACE_DIST*2.0,l,diffuse_color);

  if( d < length(light_pos-p) ){
    dif *= 0.1;
  }
  return color * dif;
}

void main(){

  vec2 u_resolution = vec2(screen_width, screen_height);
  vec2 uv = (gl_FragCoord.xy - 0.5 * u_resolution.xy)/u_resolution.y;

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
