// COPYRIGHT INFO MOVED TO THE END OF THE FILE AFTER SOURCE!
// Moved for the sake of editing convenience here:
// - http://www.kinostudios.com/mandelbulb.html
import 'dart:math';
import 'dart:ui';
import 'dart:developer' as dev;

import 'package:vector_math/vector_math_64.dart';

const HALFPI = 1.570796;
const PI = 3.141592653;

const MIN_EPSILON = 6e-7;
const MIN_NORM = 1.5e-7;

const MAX_ITERATIONS = 4;
const minRange = 6e-5;

// 10 a 200  "The maximum number of steps a ray should take."
const STEP_LIMIT = 110;

// viewMatrix and cameraPosition are automatically included by THREE.js
// uniform mat4 modelMatrix;
// uniform mat4 modelViewMatrix;
// double time = 1;
// varying Vector3 rayDir;

double width = 600.0; //=512;
double height = 600.0; //=512;
double pixelSize = 1.0; //width/height;//1.0;
int antialiasing =
    0; //"Super sampling quality. Number of samples squared per pixel.";
bool phong = true;
double shadows = 0.0;
double ambientOcclusion = 0.9;
double ambientOcclusionEmphasis =
    0.98; //"Emphasise the structure edges based on the number of steps it takes to reach a point in the fractal.";
double bounding =
    1.5; //1->16 "Sets the bounding sphere radius to help accelerate the raytracing.";
double bailout =
    2.0; //0.5->12 //"Sets the bailout value for the fractal calculation. Lower values give smoother less detailed results.";

double power = 8.0; //=8.0;//-20->20 // Power of fractal

Vector3 light = Vector3(38.0, -42.0, 38.0);
Vector4 backgroundColor = Vector4(0.0, 0.0, 0.0, 1.0);
Vector4 diffuseColor = Vector4(0.0, 0.85, 0.99, 1.0);
Vector4 ambientColor = Vector4(0.67, 0.85, 1.0, 1.0);
Vector4 lightColor = Vector4(0.48, 0.59, 0.66, 0.0);
double colorSpread = 0.2; //=0.2; // 0 -> // varier les couleurs
double rimLight = 0.0;
double specularity = 0.66;
double specularExponent = 15.0;

double epsilonScale =
    1.0; // 0 a 1  "Scale the epsilon step distance. Smaller values are slower but will generate smoother results for thin areas.";

// double phasex;
// double phasey;

// Vector2 phase = Vector2(phasex + time / 16.0, phasey - time / 16.0);

// Vector2 size = Vector2(width, height);
// double aspectRatio = size.x / size.y;

// Vector3 eye = (modelMatrix * Vector4(cameraPosition, 1)).xyz;
// Vector3 eye = Vector3.all(0.0);

// Super sampling
double sampleStep = 1.0 / (antialiasing + 1);
double sampleContribution = 1.0 / pow((antialiasing + 1), 2.0);
// double pixel_scale = 1.0 / max(size.x, size.y);

Vector2 getPhase(double time) {
  double phasex = 0.0;
  double phasey = 0.0;
  Vector2 phase = Vector2(phasex + time / 16.0, phasey - time / 16.0);
  return phase;
}

// FROM: http://www.fractalforums.com/index.php?topic=16793.msg64299#msg64299
double DE(Vector3 z0, double min_dist, double time) {
  Vector2 phase = getPhase(time);
  //MandelBulb by twinbee
  Vector4 z = Vector4.copy(z0.xyzz..w = 1.0), c = z;
  double r = z.xyz.length, zr, theta, phi, p = power; //p is the power
  phi = atan2(z.y, z.x) * p; // th = atan(z.y, z.x) + phase.x; ...and here
  theta =
      asin(z.z / r) * p; // ph = acos(z.z / r) + phase.y; add phase shifts here
  min_dist = min(min_dist, r);
  for (int n = 0; n < MAX_ITERATIONS; n++) {
    zr = pow(r, p - 1.0);
    z = Vector4.copy((Vector3.copy(
                    (Vector2(cos(phi), sin(phi)) * sin(theta)).xyx
                      ..z = cos(theta) * r)
                .xyzz
              ..w = z.w * p)) *
            zr +
        c; // this version was from the forums
    r = z.xyz.length;
    min_dist = min(min_dist, r);
    if (r > bailout) break;
    phi = (atan2(z.y, z.x) + phase.x) *
        p; // th = atan(z.y, z.x) + phase.x; ...and here
    theta = (acos(z.z / r) + phase.y) *
        p; // ph = acos(z.z / r) + phase.y; add phase shifts here
  }
  return 0.5 * log(r) * r / z.w;
}

List intersectBoundingSphere(
  Vector3 origin,
  Vector3 direction,
) {
  bool hit = false;

  double b = origin.dot(direction);
  double c = origin.dot(origin) - bounding * bounding;
  double disc = b * b - c; // discriminant
  double tmin, tmax = 0.0;

  if (disc > 0.0) {
    // Real root of disc, so intersection
    double sdisc = sqrt(disc);

    tmin =
        max(0, -b - sdisc); //DE(origin + max(0.,t0) * direction, min_dist);//
    tmax = max(0, -b + sdisc); //max(0.,t0)+t1;
    hit = true;
  }

  return [hit, tmin, tmax];
}

// Calculate the gradient in each dimension from the intersection point
Vector3 estimate_normal(Vector3 z, double e, double time) {
  double min_dst; // Not actually used in this particular case
  Vector3 z1 = z + Vector3(e, 0, 0);
  Vector3 z2 = z - Vector3(e, 0, 0);
  Vector3 z3 = z + Vector3(0, e, 0);
  Vector3 z4 = z - Vector3(0, e, 0);
  Vector3 z5 = z + Vector3(0, 0, e);
  Vector3 z6 = z - Vector3(0, 0, e);

  double dx = DE(z1, min_dst, time) - DE(z2, min_dst, time);
  double dy = DE(z3, min_dst, time) - DE(z4, min_dst, time);
  double dz = DE(z5, min_dst, time) - DE(z6, min_dst, time);

  return (Vector3(dx, dy, dz) / (2.0 * e)).normalized();
}

class Tuple2<T1, T2> {
  final T1 a1;
  final T2 a2;

  Tuple2(this.a1, this.a2);

  String toString() {
    return "a1 $a1 a2 $a2";
  }
}

// Computes the direct illumination for point pt with normal N due to
// a point light at light and a viewer at eye.
Tuple2<Vector3, double> Phong(
    Vector3 pt, Vector3 N, Matrix4 modelMatrix, Vector3 eye) {
  Vector3 diffuse = Vector3.all(0); // Diffuse contribution
  // Vector3 color   = Vector3.all(0);
  var specular = 0.0;

  // Vector3 L = normalize(light * objRotation - pt); // find the vector to the light
  Vector3 L =
      ((modelMatrix.transformed(Vector4.copy(light.xyzx..w = 1))).xyz - pt)
          .normalized();
  double NdotL =
      N.dot(L); // find the cosine of the angle between light and normal

  if (NdotL > 0.0) {
    // Diffuse shading
    var absN = Vector3.copy(N)..absolute();
    diffuse = diffuseColor.rgb + absN * colorSpread;
    var multi = lightColor.rgb * NdotL;
    diffuse.multiply(multi);

    // Phong highlight
    Vector3 E = (eye - pt).normalized(); // find the vector to the eye
    Vector3 R = L - N * 2.0 * NdotL; // find the reflected vector
    double RdE = R.dot(E);

    if (RdE <= 0.0) {
      specular = specularity * pow(RdE.abs(), specularExponent);
    }
  } else {
    diffuse = diffuseColor.rgb * NdotL.abs() * rimLight;
  }

  return Tuple2((ambientColor.rgb * ambientColor.a) + diffuse, specular);
}

// Define the ray direction from the pixel coordinates
// Vector3 rayDirection(Vector2 p)
// {
//     Vector3 direction = Vector3( 2.0 * aspectRatio * p.x / double(size.x) - aspectRatio,
//         -2.0 * p.y / double(size.y) + 1.0,
//         // -2.0 * exp(cameraZoom)
//         0.0);
//     // return normalize(direction * viewRotation * objRotation);
//     return normalize((modelViewMatrix * Vector4(direction,1)).xyz);
//     // return normalize((viewMatrix * Vector4(direction,1)).xyz);
// }

// Calculate the output colour for each input pixel
Vector4 renderPixel(Vector3 ray_direction, Size sizeP, Matrix4 modelMatrix,
    Vector3 eye, double time) {
  var list = intersectBoundingSphere(eye, ray_direction);
  // dev.log(ray_direction.toString());
  double tmin = list[1], tmax = list[2];
  Vector4 pixel_color = backgroundColor;
  Vector2 sizeVec = Vector2(sizeP.width, sizeP.height);
  double aspectRatio = sizeVec.x / sizeVec.y;

  double pixel_scale = 1.0 / max(sizeVec.x, sizeVec.y);

  if (list[0]) {
    Vector3 ray = eye + ray_direction * tmin;

    double dist, ao;
    double min_dist = 2.0;
    double ray_length = tmin;
    double eps = MIN_EPSILON;

    // number of raymarching steps scales inversely with factor
    int max_steps = STEP_LIMIT ~/ epsilonScale;
    int i = 0;
    double f = 0.0;

    for (int l = 0; l < STEP_LIMIT; ++l) {
      dist = DE(ray, min_dist, time);

      // March ray forward
      f = epsilonScale * dist;
      ray += ray_direction * f;
      ray_length += f * dist;

      // Are we within the intersection threshold or completely missed the fractal
      if (dist < eps || ray_length > tmax) {
        break;
      }

      // Set the intersection threshold as a function of the ray length away from the camera
      //eps = max(max(MIN_EPSILON, eps_start), pixel_scale * pow(ray_length, epsilonScale));
      eps = max(MIN_EPSILON, pixel_scale * ray_length);
      i++;
    }

    // Found intersection?
    if (dist < eps) {
      dev.log("dist $dist");
    dev.log("eps $eps");
      ao = 1.0 - (1.0 - min_dist * min_dist).clamp(0.0, 1.0) * ambientOcclusion;

      if (phong) {
        Vector3 normal = estimate_normal(ray, eps / 2.0, time);
        var tuble = Phong(ray, normal, modelMatrix, eye);
        double specular = tuble.a2;
        pixel_color.rgb = tuble.a1;

        if (shadows > 0.0) {
          // The shadow ray will start at the intersection point and go
          // towards the point light. We initially move the ray origin
          // a little bit along this direction so that we don't mistakenly
          // find an intersection with the same point again.
          // Vector3 light_direction = normalize((light - ray) * objRotation);
          Vector3 light_direction =
              (modelMatrix * Vector4.copy((light - ray).xyzx..w = 1)).xyz;
          ray += normal * eps * 2.0;

          double min_dist2;
          dist = 4.0;

          for (int j = 0; j < STEP_LIMIT; ++j) {
            dist = DE(ray, min_dist2, time);

            // March ray forward
            f = epsilonScale * dist;
            ray += light_direction * f;

            // Are we within the intersection threshold or completely missed the fractal
            if (dist < eps || ray.dot(ray) > bounding * bounding) break;
          }

          // Again, if our estimate of the distance to the set is small, we say
          // that there was a hit and so the source point must be in shadow.
          if (dist < eps) {
            pixel_color.rgb *= 1.0 - shadows;
          } else {
            // Only add specular component when there is no shadow
            pixel_color.rgb = pixel_color.rgb + Vector3.all(specular);
          }
        } else {
          pixel_color.rgb += Vector3.all(specular);
          
        }
      } else {
        // Just use the base colour
        pixel_color.rgb = diffuseColor.rgb;
      }

      ao *= 1.0 - (i / max_steps) * ambientOcclusionEmphasis * 2.0;
      pixel_color.rgb *= ao;
      // if (length(pixel_color.rgb) >= 0.98)
      //     pixel_color.r = 0.0;
      pixel_color.a = 1.0;
    } else {
      // some debugging to show the difference
      Vector3 ray2 = eye + ray_direction * tmin;
      var deLog = DE_blog(ray2, tmin, time);
      tmin = deLog.a2;
      dev.log("specular $deLog");
      pixel_color.r = deLog.a1 / bailout;
      var deOriginal = DE_original(ray2, tmin, time);
      tmin = deOriginal.a2;
      pixel_color.g = deOriginal.a1 / bailout;
      pixel_color.b = DE(ray2, tmin, time) / bailout;
    }
  } else {
    pixel_color = Vector4(0.3, 0, 0, 1);
  }

  return pixel_color;
}

// void main() {
//   var rayDir = Vector3.all(0.0);
//   Matrix4 modelMatrix = Matrix4.identity();
//   var eye = Vector3.all(0.0);
//   var size = Size(0, 0);
//   renderPixel(rayDir.normalized(), size, modelMatrix, eye);
// }

/**
Most of this code was copied from:
https://code.google.com/p/webgl-mandelbulb/source/browse/3dmandelbrot.html
The original changelog/copyright/licencse copied below after the dashed line.

three.js modifications by:

Greg Slepak
https://twitter.com/taoeffect
https://github.com/taoeffect

With special thanks to:
- eiffie
- Syntopia
- knighty
- cKleinhuis

And everyone else on the fractalforums!
http://www.fractalforums.com/mandelbulb-implementation/webgl-mandelbulb-with-three-js-flythrough-controls-(optimizations-wanted)

Last update: August 11, 2013

Changelog:
    1.1   - Two additional DE functions to choose from, now using the one from the forums
            because it's faster. Ray direction now calculated using 'modelViewProjectMatrixInverse'
            Original DE function renamed to 'DE_original'. Phase disabled because it looks ugly
            with the new DE functions.

---------------------------------------------------

 3dmandelbrot was put together by:
 Michael Jewell <michael.jewell@maine.edu>,  
 Jesse Altman <jesse.altman@maine.edu>,
 Shane Christy <shane.christy@maine.edu>,
 Kayla Christina Artinyan <kayla.artinyan@maine.edu> from the universtiy of southern maine for Bruce Macleod's Interactive Graphics course
 
 The origin of our mandelbulb equations:
 * Mandelbulb.pbk
 * Last update: 14 December 2009
 *
 * Changelog:
 *      1.0     - Initial release
 *      1.0.1   - Fixed a missing asymmetry thanks to Chris King (http://www.dhushara.com)
 *              - Refinements in the colouring
 *      1.0.2   - Added radiolaria option for a funky hair-like effect
 *              - Incorporated the scalar derivative method as described here:
 *              - http://www.fractalforums.com/mandelbulb-implementation/realtime-renderingoptimisations/
 *      1.0.3   - Created a quick version of the script as using a boolean flag to determine
 *                which distance estimation method created long compilation times.
 *      1.0.4   - Fixed issue with older graphic cards and the specular highlights
 *
 *
 * Copyright (c) 2009 Tom Beddard
 * http://www.subblue.com
 *
 * For more Flash and PixelBender based generative graphics experiments see:
 * http://www.subblue.com/blog
 *
 * Licensed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 *
 * Credits and references
 * ======================
 * For the story behind the 3D Mandelbrot see the following page:
 * http://www.skytopia.com/project/fractal/mandelbulb.html
 *
 * The original forum disussion with many implementation details can be found here:
 * http://www.fractalforums.com/3d-fractal-generation/true-3d-mandlebrot-type-fractal/
 *
 * This implementation references the 4D Quaternion GPU Raytracer by Keenan Crane:
 * http://www.devmaster.net/forums/showthread.php?t=4448
 *
 * and the NVIDIA CUDA/OptiX implementation by cbuchner1:
 * http://forums.nvidia.com/index.php?showtopic=150985
 *
 *  -- noise provided by --
 *The following is noise calculations are provided from
 * Original noise Author: Stefan Gustavson ITN-LiTH (stegu@itn.liu.se) 2004-12-05
 * Simplex indexing functions by Bill Licea-Kane, ATI
 *
 * You may use, modify and redistribute this code free of charge,
 * provided that the author's names and this notice appear intact.
 *
 * The code was hosted at http://www.pcprogramming.com/NoiseCube.html
 */

//  #ifdef OLD_CODE

bool radiolaria = false;
double radiolariaFactor = 0.0;

// double DE_conversion_attempt_in_progress_(Vector3 z0, inout double min_dist)
// {
//     Vector4 z = Vector4(z0, 1.0);
//     double pd = power - 1.0;          // power for derivative

//     // Convert z to polar coordinates
//     double r    = length(z), theta,phi;

//     // Record z orbit distance for ambient occulsion shading
//     if (r < min_dist) min_dist = r;

//     Vector3 dz;
//     double ph_dz = 0.0;
//     double th_dz = 0.0;
//     double powR, powRsin;

//     // Iterate to compute the distance estimator.
//     for (int n=0; n < MAX_ITERATIONS; n++) {
//         phi = atan(z.y, z.x) + phase.x;
//         theta = acos(z.z / r) + phase.y;

//         // Calculate derivative of
//         powR = power * pow(r, pd);
//         powRsin = powR * z.w * sin(ph_dz + pd*theta);
//         dz.x = powRsin * cos(th_dz + pd*phi) + 1.0;
//         dz.y = powRsin * sin(th_dz + pd*phi);
//         dz.z = powR * z.w * cos(ph_dz + pd*theta);

//         // polar coordinates of derivative dz
//         z.w  = length(dz);
//         th_dz = atan(dz.y, dz.x);
//         ph_dz = acos(dz.z / z.w);

//         // z iteration
//         powRsin = sin(power*theta);
//         z.x = powR * powRsin * cos(power*phi);
//         z.y = powR * powRsin * sin(power*phi);
//         z.z = powR * cos(power*theta);
//         z += z0;
//         z = powR *  Vector4()

//         // The triplex power formula applies the azimuthal angle rotation about the y-axis.
//         // Constrain this to get some funky effects
//         if (radiolaria && z.y > radiolariaFactor) z.y = radiolariaFactor;

//         r  = length(z);
//         if (r < min_dist) min_dist = r;
//         if (r > bailout) break;

//     }

//     // Return the distance estimation value which determines the next raytracing
//     // step size, or if whether we are within the threshold of the surface.
//     return 0.5 * r * log(r)/z.w;
// }

// // Intersect bounding sphere
// //
// // If we intersect then set the tmin and tmax values to set the start and
// // end distances the ray should traverse.
// bool intersectBoundingSphere(Vector3 origin,
//     Vector3 direction,
//     out double tmin,
//     out double tmax)
// {
//     bool hit = false;

//     //Vector3 pN = Vector3(0, 0, 1.0);
//     //double  t  = -(dot(origin, pN) + slice) / dot(direction, pN);
//     //origin = origin + t * direction;

//     double b = dot(origin, direction);
//     double c = dot(origin, origin) - bounding;
//     double disc = b*b - c;         // discriminant
//     tmin = tmax = 0.0;

//     if (disc > 0.0) {
//         // Real root of disc, so intersection
//         double sdisc = sqrt(disc);
//         double t0 = -b - sdisc;         // closest intersection distance
//         double t1 = -b + sdisc;         // furthest intersection distance

//         if (t0 >= 0.0) {
//             // Ray intersects front of sphere
//             double min_dist;
//             Vector3 z = origin + t0 * direction;
//             tmin = DE(z, min_dist);
//             tmax = t0 + t1;
//         } else if (t0 < 0.0) {
//             // Ray starts inside sphere
//             double min_dist;
//             Vector3 z = origin;
//             tmin = DE(z, min_dist);
//             tmax = t1;
//         }
//         hit = true;
//     }

//     return hit;
// }

// // The fractal calculation
// //
// // Calculate the closest distance to the fractal boundary and use this
// // distance as the size of the step to take in the ray marching.
// //
// // Fractal formula:
// //     z' = z^p + c
// //
// // For each iteration we also calculate the derivative so we can estimate
// // the distance to the nearest point in the fractal set, which then sets the
// // maxiumum step we can move the ray forward before having to repeat the calculation.
// //
// //    dz' = p * z^(p-1)
// //
// // The distance estimation is then calculated with:
// //
// //   0.5 * |z| * log(|z|) / |dz|
// //
Tuple2<double, double> DE_original(Vector3 z0, double min_dist, double time) {
  Vector3 c = z0; // Julia set has fixed c, Mandelbrot c changes with location
  Vector3 z = z0;
  double pd = power - 1.0; // power for derivative

  // Convert z to polar coordinates
  double r = (z).length;
  double th = atan2(z.y, z.x);
  double ph = asin(z.z / r);

  // Record z orbit distance for ambient occulsion shading
  if (r < min_dist) min_dist = r;

  Vector3 dz = Vector3.all(0);
  double ph_dz = 0.0;
  double th_dz = 0.0;
  double r_dz = 1.0;
  double powR, powRsin;
  Vector2 phase = getPhase(time);
  // Iterate to compute the distance estimator.
  for (int n = 0; n < MAX_ITERATIONS; n++) {
    // Calculate derivative of
    powR = power * pow(r, pd);
    powRsin = powR * r_dz * sin(ph_dz + pd * ph);
    dz.x = powRsin * cos(th_dz + pd * th) + 1.0;
    dz.y = powRsin * sin(th_dz + pd * th);
    dz.z = powR * r_dz * cos(ph_dz + pd * ph);

    // polar coordinates of derivative dz
    r_dz = (dz).length;
    th_dz = atan2(dz.y, dz.x);
    ph_dz = acos(dz.z / r_dz);

    // z iteration
    powR = pow(r, power);
    powRsin = sin(power * ph);
    z.x = powR * powRsin * cos(power * th);
    z.y = powR * powRsin * sin(power * th);
    z.z = powR * cos(power * ph);
    z += c;

    // The triplex power formula applies the azimuthal angle rotation about the y-axis.
    // Constrain this to get some funky effects
    if (radiolaria && z.y > radiolariaFactor) z.y = radiolariaFactor;

    r = (z).length;
    if (r < min_dist) min_dist = r;
    if (r > bailout) break;

    th = atan2(z.y, z.x) + phase.x;
    ph = acos(z.z / r) + phase.y;
  }

  // Return the distance estimation value which determines the next raytracing
  // step size, or if whether we are within the threshold of the surface.
  return Tuple2(0.5 * r * log(r) / r_dz, min_dist);
}

// // FROM: http://blog.hvidtfeldts.net/index.php/2011/09/distance-estimated-3d-fractals-v-the-mandelbulb-different-de-approximations/
Tuple2<double, double> DE_blog(Vector3 pos, double min_dist, double time) {
  Vector3 z = pos;
  double dr = 1.0;
  double r = z.length;
  Vector2 phase = getPhase(time);
  if (r < min_dist) min_dist = r;
  for (int i = 0; i < MAX_ITERATIONS; i++) {
    // convert to polar coordinates
    double theta = acos(z.z / r) + phase.y;
    double phi = atan2(z.y, z.x) + phase.x;
    dr = pow(r, power - 1.0) * power * dr + 1.0;

    // scale and rotate the point
    double zr = pow(r, power);
    theta = theta * power;
    phi = phi * power;

    // convert back to cartesian coordinates
    z = Vector3(sin(theta) * cos(phi), sin(phi) * sin(theta), cos(theta)) * zr;
    z += pos;

    r = z.length;
    if (r < min_dist) min_dist = r;
    if (r > bailout) break;
  }
  return Tuple2(0.5 * log(r) * r / dr, min_dist);
}

// // FROM: http://www.fractalforums.com/index.php?topic=16793.msg64299#msg64299
// double DE_forum_original(Vector3 z0, inout double min_dist){//MandelBulb by twinbee
//     Vector4 z = Vector4(z0,1.0), c = z;
//     double r = length(z.xyz),zr,theta,phi,p=power;//p is the power
//     if (r < min_dist) min_dist = r;
//     for (int n = 0; n < MAX_ITERATIONS; n++) {
//         // phi = atan(z.y, z.x) * p;// th = atan(z.y, z.x) + phase.x; ...and here
//         // theta = asin(z.z / r) * p;// ph = acos(z.z / r) + phase.y; add phase shifts here
//         phi = (atan(z.y, z.x) + phase.x) * p;// th = atan(z.y, z.x) + phase.x; ...and here
//         theta = (asin(z.z / r) + phase.y) * p;// ph = acos(z.z / r) + phase.y; add phase shifts here
//         zr = pow(r, p-1.0);
//         z=zr*Vector4(r*Vector3(cos(theta)*Vector2(cos(phi),sin(phi)),sin(theta)),z.w*p)+c; // this version was from the forums
//         // z = zr*Vector4(r*Vector3(sin(theta)*Vector2(cos(phi),sin(phi)), cos(theta)),z.w*p)+c; // this version from the blog
//         r = length(z.xyz);
//         if (r < min_dist) min_dist = r;
//         if (r > bailout) break;
//     }
//     return 0.5 * log(r) * r / z.w;
// }

// #endif
