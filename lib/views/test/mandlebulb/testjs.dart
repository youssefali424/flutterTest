
// import 'dart:math' as Math;

// import 'package:vector_math/vector_math_64.dart';

// class Ray{
//   double rayMaxSteps, rayMinDist, calcLight;
//   Ray({this.rayMaxSteps, this.rayMinDist, this.calcLight});
// }
// class Camera{
//  double yaw, pitch, speed, rotateSpeed, fov;
//  bool locked;
//   Camera({this.yaw, this.fov, this.locked, this.speed, this.rotateSpeed, this.pitch});
// }
// class Size{
//   double pxWidth,pxHeight;
//   Size({this.pxWidth, this.pxHeight});
// }
// class Params{
//   Ray ray;
//   Vector3 eye,
//                     light,
//                     target,
//                     vertical;// wektor pionu
//                     Size screen;  
//                     Camera camera; 
//   Params({this.ray, this.camera, this.target, this.vertical, this.screen, this.light,this.eye});
// }
// class RaytracerParams {
//  Params params;
//             RaytracerParams() {
//                 this.params = Params(
//                     ray: Ray(rayMaxSteps:512, rayMinDist:0.001, calcLight: 1 ),
//                     eye:    Vector3(0, 1, 0 ),
//                     light:    Vector3(-10, 10, 10 ),
//                     target:    Vector3(0, 0, 1 ),
//                     vertical: Vector3( 0, 1,  0), // wektor pionu
//                     screen: Size( pxWidth:0,pxHeight: 0 ),     
//                     camera: Camera(yaw: 0, pitch: 0, speed: 0.01, rotateSpeed: 0.01, fov: 90, locked: true )               
//                 );
//             }

//             getParams() {
//                 return this.params;
//             }

//             setScreenSize(width, height) {
//                 this.params.screen.pxWidth = width;
//                 this.params.screen.pxHeight = height;
//                 return this;
//             }

//             // yaw = left/right, pitch = up/down
//             // [x,y,z] = position
//             moveCamera(yawDelta, pitchDelta, forwardBackward, leftRight, upDown) { 
//                 var e = this.params.eye;
//                 var t = this.params.target;
//                 var v = this.params.vertical;
//                 var d =Vector3.copy(t);// this.sub(t,e);
//                 d.sub(e);

//                 this.params.camera.yaw += yawDelta * this.params.camera.rotateSpeed;
//                 this.params.camera.pitch += pitchDelta * this.params.camera.rotateSpeed;
//                 var yaw = this.params.camera.yaw;
//                 var pitch = this.params.camera.pitch;

//                 // rotate
//                 t.x = e.x + Math.sin(yaw)*Math.cos(pitch);
//                 t.z = e.z + Math.cos(yaw)*Math.cos(pitch);                
//                 t.y = e.y + Math.sin(pitch); 
                
//                 // move forward                                
//                 var fb = d*( this.params.camera.speed * forwardBackward );
//                 e.add(fb);//this.addInPlace(e,fb);
//                 t.add(fb);// this.addInPlace(t,fb);


//                 // move left-right
//                 var lr = v.cross(d).normalized()*( this.params.camera.speed * leftRight);
//                 e.add(lr);//this.addInPlace(e,lr);
//                 t.add(lr);//this.addInPlace(t,lr);

//                 // move up-down
//                 var ud = v*( this.params.camera.speed * upDown);
//                 e.add(ud);//this.addInPlace(e,ud);
//                 t.add(ud);//this.addInPlace(t,ud);
//             }

//             calcRayBase() {
//                 var E = this.params.eye;
//                 var T = this.params.target;
//                 var w = this.params.vertical;

//                 // var t = this.sub(T,E); // = viewport center
//                 var t=Vector3.copy(T);
//                  t.sub(E);
//                 var tn = t.normalized();

//                 var bn = w.cross(t).normalized();
//                 // var bn = b.normalized();

//                 var vn = tn.cross(bn);//this.cross(tn,bn);

//                 var m = this.params.screen.pxHeight;
//                 var k = this.params.screen.pxWidth;                
//                 var gx = Math.tan((2*Math.pi*this.params.camera.fov/360)/2);                
//                 var gy = gx*m/k;
//                 // vn.s
//                 // P1M is left bottom viewport pixel
//                 var P1M = this.add([tn,bn*-gx,vn*-gy ]); // chnage C to tn (tn= C-E)

//                 var QX = bn*(2*gx/(k-1));
//                 var QY = vn*(2*gy/(m-1));

//                 // Pij = P1M + (i-1)*bnp + (j-1)*vnp
//                 return {E, P1M, QX, QY};

//             }

//             // cross(a,b) {
//             //     var x = a.y*b.z - a.z*b.y; 
//             //     var y = a.z*b.x - a.x*b.z; 
//             //     var z = a.x*b.y - a.y*b.x; 
//             //     return {x,y,z};
//             // }

//             // norm(a) {
//             //     var size = 1/Math.sqrt(a.x*a.x + a.y*a.y + a.z*a.z);
//             //     return {x: a.x*size, y: a.y*size, z: a.z*size };
//             // }

//             // addInPlace(a,b) {
//             //     a.x += b.x;
//             //     a.y += b.y;
//             //     a.z += b.z;
//             //     return a;
//             // }

//             // add(...vs) {
//             //     return vs.reduce( (a,b) => ({ x: a.x+b.x, y: a.y+b.y, z: a.z+b.z }) )
//             //     // return { 
//             //     //     x: a.x + b.x,
//             //     //     y: a.y + b.y,
//             //     //     z: a.z + b.z
//             //     // }
                
//             // }
//             Vector3 add(List<Vector3> vectors){
//               return vectors.reduce((value, element) => value + element);
//             }

//             // sub(a,b) {
//             //     return this.add(a,this.scale(-1,b));
//             // }

//             // scale(s, a) {
//             //     return { x: a.x*s, y: a.y*s, z: a.z*s }
//             // }
//         }

       
//         // ---------------------------------------------------- 
//         //
//         // GPU & Canvas
//         //
//         // ---------------------------------------------------- 

//             // T - target
//             // E - eye
//             // vvn - wektor pionu kamery (normalny)
//             // fov - kont widzenia (stopnie)
//             // ar - aspect ratio
//             // k - liczba pixeli widht
//             // m - liczba pixeli height
//          kernelMarchingRays(calcLight, rayMaxSteps, rayMinDist, Ex,Ey,Ez, P1Mx, P1My, P1Mz, QXx, QXy, QXz, QYx, QYy,QYz, Lx, Ly, Lz) 
//         {                            
//             var i = this.thread.x;
//             var j = this.thread.y;
//             var rx = P1Mx + QXx*(i-1) + QYx*(j-1);
//             var ry = P1My + QXy*(i-1) + QYy*(j-1);
//             var rz = P1Mz + QXz*(i-1) + QYz*(j-1);

//             var sr = 1/Math.sqrt(rx*rx + ry*ry + rz*rz);
//             var rnx = rx*sr;
//             var rny = ry*sr;
//             var rnz = rz*sr;

//             var totalDistance = 0.0;
//             var MaximumRaySteps= rayMaxSteps; //255;
//             var MinimumDistance= rayMinDist; //0.0001;                
//             var stepsVal = 0;
//             var ppx = 0;
//             var ppy = 0;
//             var ppz = 0;
//             var distance = 0;
//             var hit = 0;
//             List<double> dd= [0,0,0];
//             var hitObjectId = 0; // 0 = no hit
                        
//             for (var steps=0 ; steps < MaximumRaySteps; steps++) {
//                 ppx = Ex + totalDistance * rnx;
//                 ppy = Ey + totalDistance * rny;
//                 ppz = Ez + totalDistance * rnz;

//                 dd = distScene(ppx,ppy,ppz);
//                 distance = dd[0]; // --- Distance estimator
                
//                 totalDistance += distance;
//                 if (distance < MinimumDistance) {
//                     stepsVal = steps;     
//                     hit=1;          
//                     hitObjectId = dd[2];         
//                     break;                
//                 };
                
//             }

//             var iterFrac = dd[1];
            
//             var color_r = 0;
//             var color_g = 0;
//             var color_b = 0;

//             // --- calculate normals and light ---
//             if(calcLight==1) {                                
//                 var eps = rayMinDist*10;
//                 if(eps>0.00015) { eps = 0.00015; }
                
//                 dd = distScene(ppx + eps, ppy, ppz);
//                 double nx = dd[0] - distance; // - distScene(ppx - eps, ppy, ppz);
//                 dd = distScene(ppx, ppy + eps, ppz);
//                 var ny = dd[0] - distance; // - distScene(ppx, ppy - eps, ppz);
//                 dd = distScene(ppx, ppy, ppz + eps);                
//                 var nz = dd[0] - distance; // - distScene(ppx, ppy, ppz - eps); 
                
//                 var sn = 1/Math.sqrt(nx*nx + ny*ny + nz*nz);
//                 nx = nx * sn;
//                 ny = ny * sn;
//                 nz = nz * sn;

//                 var lx = Lx - ppx;
//                 var ly = Lz - ppy;
//                 var lz = Lz - ppz;
//                 var sl = 1/Math.sqrt(lx*lx + ly*ly + lz*lz);
//                 lx *= sl;
//                 ly *= sl;
//                 lz *= sl;


//                 //var colBcg = hsv2rgb(0.6,1,0.2*(0.4+((i+j))/(1024)));
//                 //var colBcg = [j/4024,i/4024,0];
//                 var colBcg = [0,0,0];
//                 var light = lx * nx + ly*ny + lz*nz;
//                 light = (light+1)/2;                
//                 //var col = hsv2rgb(((iterFrac*666)%100)/10, 1, light);
//                 var distLight = -10/Math.log2(rayMinDist);///totalDistance; //1.0/(Math.pow(totalDistance,5));
//                 //if(distLight>1) distLight=1;
//                 var col = hsv2rgb(
//                     (ppx+ppy+ppz),
//                     1,
//                     distLight*8*light*stepsVal/MaximumRaySteps
//                     );

                
//                 color_r = col[0]; 
//                 color_g = col[1];
//                 color_b = col[2];

//                 if(hitObjectId==0) {
                    
//                     color_r = colBcg[0];
//                     color_g = colBcg[1];
//                     color_b = colBcg[2];
//                 }

//                 if(hitObjectId==1) {
//                     color_r = 0;
//                     color_g = 1*light;
//                     color_b = 0;
//                 }

//                 //color_r = Math.max(light,0) + hit*0.2;
//                 //color_g = light;
//                 //color_b = light;

//             } else {
//                 var trace= 2*stepsVal/MaximumRaySteps;
//                 color_r = trace;
//                 color_g = trace;
//                 color_b = trace;
//             }

//             this.color(color_r, color_g, color_b ,1);
//         }

//         function hsv2rgb(h,s,v) {
//             //h = 3.1415*2*(h%360)/360;
//            // h=3.1415*2*h/100; // 100 is from max number of function mandelbulb iterations
            
//             var c = v*s;
//             var k = (h%1)*6;
//             var x = c*(1 - Math.abs(k%2-1));
            
//             var r=0;
//             var g=0;
//             var b=0;
            
//             if(k>=0 && k<=1) { r=c; g=x }
//             if(k>1 && k<=2)  { r=x; g=c }
//             if(k>2 && k<=3)  { g=c; b=x }
//             if(k>3 && k<=4)  { g=x; b=c }
//             if(k>4 && k<=5)  { r=x; b=c }
//             if(k>5 && k<=6)  { r=c; b=x }
            
//             var m = v-c;
            
//             return [r+m,g+m,b+m]  
//         }

//         // x,y,z - point on ray (marching)
//         function distScene(x,y,z) 
//         {                       
//             //var p = sdPlane(x,y,z, 0,1,0,1);            
//             var mm = mandelbulb(x,y,z);                        
//             var m = mm[0];
//             var letIter = mm[1];
//             var dis = m; //Math.min(p,m);                        
//             //var dis = Math.min(p,m);                        
//             var objId =1; // 1= plane
//             if(dis==m) objId =2; // 2= plane
            
//             return [ dis, letIter, objId ] ;
//         }

//         function sdPlane(px,py,pz, nx,ny,nz,nw) 
//         {            
//             return px*nx + py*ny + pz*nz + nw;
//         }

//         function mandelbulb(px,py,pz) {
//             var zx=px; var zy=py; var zz=pz;        
//             var dr = 1;
//             var r = 0;
//             var iterations = 100;
//             var bailout = 2;
//             var power = 8;
//             var j=0;

//             for (var i=0 ; i < iterations ; i++) {                
//                 r = Math.sqrt(zx*zx + zy*zy + zz*zz);
//                 if (r>bailout) break;
                
//                 // convert to polar coordinates
//                 var theta = Math.acos(zz/r);
//                 var phi = Math.atan(zy,zx);
                
//                 dr =  Math.pow( r, power-1.0)*power*dr + 1.0;
                
//                 // scale and rotate the point
//                 var zzr = Math.pow( r,power);
//                 theta = theta*power;
//                 phi = phi*power;
                
//                 // convert back to cartesian coordinates
//                 zx = zzr * sin(theta) * cos(phi);
//                 zy = zzr * sin(phi) * sin(theta);
//                 zz = zzr * cos(theta);
//                 zx+=px;
//                 zy+=py;
//                 zz+=pz;

//                 j++;
//             }
//             return [0.5*Math.log(r)*r/dr, j];
//         }





//         // Pointer Locking enable 
//         // https://www.html5rocks.com/en/tutorials/pointerlock/intro/
//         // https://w3c.github.io/pointerlock/
//         // continue this tommorow...
//         function canvasOnClick_enablePointerLocking(event) {
//             if(par.camera.locked) {
//                 var canvas = event.target;
                
//                 canvas.requestPointerLock = canvas.requestPointerLock ||
//                     canvas.mozRequestPointerLock ||
//                     canvas.webkitRequestPointerLock;
//                 // Ask the browser to lock the pointer
                                                                
//                 canvas.requestPointerLock();
//             }
//         }

//         function lockChange(e) {            
//             par = raytracerParams.getParams();
//             par.camera.locked = !par.camera.locked;
//         }

//         function initFractalGPU(raytracerParams) {
//             params = raytracerParams.getParams();
//             var pxWidth = params.screen.pxWidth;
//             var pxHeight = params.screen.pxHeight;
//             var canvas = document.getElementById("myCanvas");
//             if(canvas) { canvas.remove(); }
//             canvas = document.createElement('canvas');
//             canvas.id = 'myCanvas';
//             document.body.querySelector('.panel').appendChild(canvas);

//             //canvas.width = pxWidth;
//             //canvas.height = pxHeight;

//             canvas.addEventListener('click', canvasOnClick_enablePointerLocking);
//             document.addEventListener('pointerlockchange', lockChange, false);
            
//             const gl = canvas.getContext('webgl2', { premultipliedAlpha: false });
//             const gpu = new GPU({ canvas, webGl: gl });
            
//             const raytracer = gpu.createKernel(kernelMarchingRays)
//                 .setConstants({ pxWidth, pxHeight })
//                 .setOutput([pxWidth, pxHeight])    
//                 .setGraphical(true)
//                 .setLoopMaxIterations(10000)
//                 .setFunctions([                                                                                
//                     sdPlane,                                                             
//                 ]);
//             gpu.addFunction(mandelbulb, { returnType: 'Array(2)' });
//             gpu.addFunction(distScene, { returnType: 'Array(3)' });
//             gpu.addFunction(hsv2rgb, { returnType: 'Array(3)' });
//             return raytracer;
//         }

//         // ---------------------------------------------------- 
//         //
//         // UX
//         //
//         // ---------------------------------------------------- 

//         function initGui() {               
//             raytracer.getCanvas().addEventListener('wheel',(event) => { mouseWheel(event); return false; }, false);
//             raytracer.getCanvas().addEventListener('mousemove',(event) => { mouseMove(event); return false; }, false);            
//             document.onkeypress = (e) => { 
//                 if(e.key == "w") moveCamera(1,0,0); 
//                 if(e.key == "s") moveCamera(-1,0,0); 
//                 if(e.key == "a") moveCamera(0,-1,0); 
//                 if(e.key == "d") moveCamera(0,1,0); 
//                 if(e.key == "e") moveCamera(0,0,1); 
//                 if(e.key == "c") moveCamera(0,0,-1); 

//                 if(e.key == "+") mouseWheel({deltaY: -10}); 
//                 if(e.key == "-") mouseWheel({deltaY: 10}); 
//             };
//             chceckScreenResize();

//             refresh();            
//         }

//         function moveCamera(forwardBackward, leftRight, upDown) {
//             par = raytracerParams.getParams();
//             par.camera.locked             
//             raytracerParams.moveCamera(0,0, forwardBackward, leftRight, upDown);
//             refresh();
//         }
                
//         function refresh() 
//         {               
//             // unlock on refresh demand 
//             // (after changing some render parameter by key/mose move)
//             locked = false; 
//         }

//         function refreshWindow(timestamp) {            
//             // redraw only if some render parameter change (user move mose, push button etc.)
//             if(!locked) { 
//                 locked = true;
//                 var par = raytracerParams.getParams();
//                 var r = raytracerParams.calcRayBase(); // {E, P1M, Bn, Vn};
                
//                 raytracer(
//                     par.ray.calcLight, par.ray.rayMaxSteps, par.ray.rayMinDist,
//                     r.E.x, r.E.y, r.E.z, 
//                     r.P1M.x, r.P1M.y, r.P1M.z, 
//                     r.QX.x, r.QX.y, r.QX.z, 
//                     r.QY.x, r.QY.y, r.QY.z, 
//                     par.light.x, par.light.y, par.light.z, 
//                 );                                       
//             }
            
//             //
//             window.requestAnimationFrame(refreshWindow);
//         }

//         function mouseMove(e) {  
//             par = raytracerParams.getParams();
            
//             //var canvas = document.getElementById("myCanvas");  
//             //console.log('clock',canvas.requestPointerLock);
            
//             //raytracerParams.moveCamera(e.offsetX/100, e.offsetY/100); // yaw = left/right, pitch = up/down
//             if(!par.camera.locked) {
//                 raytracerParams.moveCamera(e.movementX, -e.movementY, 0,0,0); // yaw = left/right, pitch = up/down
//                 refresh();
//             }
//         }
            
//         function mouseWheel(e) {                        
//             tmpMouseWhellY += e.deltaY;
//             tmpMouseWhellY = tmpMouseWhellY>-2000 ? -2000 : tmpMouseWhellY;
//             tmpMouseWhellY = tmpMouseWhellY<-8000 ? -8000 : tmpMouseWhellY;
//             n = Math.pow(10, tmpMouseWhellY/1000);
                        
//             par.ray.rayMinDist = n;   
//             par.camera.speed = n*10;
            
//             document.querySelector("#rayMinDist").value = Math.floor((-tmpMouseWhellY-2000)/6);
//             refresh();            
//         }



//         function chceckScreenResize() {
//             window.addEventListener("resize",() => {
//                 //refreshScreenSize();
//             });
//         }

//         function refreshScreenSize() {
//             //raytracerParams.setScreenSize(window.innerWidth, window.innerHeight);
//             raytracerParams.setScreenSize(500, 500);
//             raytracer = initFractalGPU(raytracerParams);    
//             refresh();
//         }

//         function settingsSetLight(e) {
//             par = raytracerParams.getParams();
//             par.ray.calcLight = 1-par.ray.calcLight;
//             refresh();
//         }

//         function settingsRayMinDist(e, direct=false) {
            
//             var n = ("0." + "0".repeat(e.target.value-1) + "1")*1;   
//             par.ray.rayMinDist = n;   
//             par.camera.speed = n*10;
            
//             document.querySelector("#rayMinDist").value = e.target.value;
//             refresh();
//             //rayMinDist
//             //par = raytracerParams.getParams();
//         }

//         function settingsRayMaxSteps(e) {            
//             par = raytracerParams.getParams();
//             par.ray.rayMaxSteps = e.target.value;   
//             document.querySelector("#rayMaxSteps").value = par.ray.rayMaxSteps;
//             refresh();         
//         }


//         // ---------------------------------------------------- 
//         //
//         // Main
//         //
//         // ---------------------------------------------------- 
//         var raytracerParams = new RaytracerParams();
//         var tmpMouseWhellY = -3000;
//         var locked = false;
//         var start;
//         refreshScreenSize();
//         //var raytracer = initFractalGPU(raytracerParams);         
//         initGui(raytracerParams);

//         window.requestAnimationFrame(refreshWindow);

