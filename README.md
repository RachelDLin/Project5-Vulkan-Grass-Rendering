Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

Rachel Lin

* [LinkedIn](https://www.linkedin.com/in/rachel-lin-452834213/)
* [personal website](https://www.artstation.com/rachellin4)
* [Instagram](https://www.instagram.com/lotus_crescent/)

Tested on: Windows 11, 12th Gen Intel(R) Core(TM) i7-12700H @ 2.30GHz, NVIDIA GeForce RTX 3080 Laptop GPU (16 GB)

### Feature Overview
* Simulating Forces
  * Gravity
  * Recovery
  * Wind
* Culling
  * Orientation culling
  * View-frustum culling
  * Distance culling
* Tesselation
* Simple lambertian shading

### References
* [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)

# Overview

<img src="img/demo.gif" width="50%">

This project is an implementation of the paper [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf) by Klemens Jahrmann and Michael Wimmer on the GPU. A compute pipeline is used for calculating forces and determining culling for each blade before the graphics pipeline renders out the scene.

# Data Representation

Grass blades are represented as 2nd-degree bezier curves (three control points). Data for each blade is stored as follows:
* `v0.xyz`: the position of control point 0 (the bottom endpoint)
* `v0.w`: the orientation of the blade
* `v1.xyz`: the position of control point 1 (the midpoint)
* `v1.w`: the height of the grass blade
* `v2.xyz`: the position of control point 2 (the top endpoint)
* `v2.w`: the width of the base of the grass blade
* `up.xyz`: the "up" direction of the blade
* `up.w`: the stiffness of the blade

<img src="img/blade_model.jpg" width="50%">

# Features

## Forces

Force calculations are computed on the base bezier curve in the compute step before rendering is performed. While this simulation is physics-inspired, it takes some liberties with approximations and does not represent gravity and a spring force in a way that is completely physically accurate.

The total force is simply a sum of the three forces described below. To keep the grass blade from changing length, the positions of `v1` and `v2` are also corrected after applying the force and calculating control point displacement.

| Gravity | Wind	| 
| --------- | --------- |
| <img src="img/gravity.gif" width="100%"> | <img src="img/wind.gif" width="100%"> | 

### Gravity

The gravitational force is computed by combining the environmental gravity (`gE = g * t`) with a "front gravity" approximation (`gF = abs(gE) * forward / 4`) to create a bend in the grass blade.

### Recovery

The recovery force is a counter-force that brings the grass blade back to equilibrium based on the grass's stiffness: `r = (v2_initial - v2) * stiffness`.

### Wind

The wind is represented by a direction and strength, which are computed procedurally using a combination of sinusoids and perlin noise as a base. The final wind force is calculated as `w = windStrength * windDirection * windAlignment`.

## Culling

| Orientation Culling | View Frustum Culling	| Distance Culling	|
| --------- | --------- | --------- |
| <img src="img/orientation_culling.gif" width="100%"> | <img src="img/viewfrustum_culling.gif" width="100%"> | <img src="img/distance_culling.gif" width="100%"> |


### Orientation Culling

Blades that do not align with the view vector are culled. Culling is determined through a simple check using a dot product: `dot(cameraDirection, bladeDirection) < 0.9`.

### View-Frustum Culling

Blades that are outside of the view frustum of the camera don't need to be drawn because they are outside of the view of the screen. This is done by mapping world coordinates to normalized device coordinates. Any blades that are outside of the range `[-1.0, 1.0]` are culled, preventing expensive rendering calculations in the graphics pipeline.

### Distance Culling

Blades that are too far to require rendering of individual blades as geometry are culled. In practice, these should be replaced by grass billboards.

### Performance

At a closer distance, distance culling is minimal because all blades in the patch in the patch of grass in the test scene are too close to the camera to be culled. At a farther distance, we observe a greater improvement from distance culling.

With view-frustum culling, this idea is flipped. At a closer distance, blades outside of the screen are culled, whereas at a farther distance, most blades are within the field of view and are not culled.

We see a more consistent trend with orientation culling, as the proportion of blades that are aligned with the look direction will not change with camera distance.

We also observe a performance dip with culling in the 0-2000 range of blades. This is likely because the compute cost of culling outweighs the performance gains. Since there are not many blades to begin with, the number of blades culled (and the cost savings in the rendering step) is not worth it for the extra calculation in the compute step. However, we see a much greater payoff with all culling methods as the number of blades of grass increases. In practice, a video game would likely have a large field of grass rather than just a small patch, so all three culling methods could be very applicable depending on the scene.

<img src="img/FPS vs. Culling Method near.png" width="50%">

<img src="img/FPS vs. Culling Method far.png" width="50%">


