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



### View-Frustum Culling

### Distance Culling

### Performance

<img src="img/FPS vs. Culling Method near.png" width="100%">

<img src="img/FPS vs. Culling Method far.png" width="100%">


