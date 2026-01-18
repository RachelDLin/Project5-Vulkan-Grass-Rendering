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

# Features

## Forces

| Gravity | Wind	| 
| --------- | --------- |
| <img src="img/gravity.gif" width="100%"> | <img src="img/wind.gif" width="100%"> | 


### Gravity

### Recovery

### Wind


## Culling

| Orientation Culling | View Frustum Culling	| Distance Culling	|
| --------- | --------- | --------- |
| <img src="img/orientation_culling.gif" width="100%"> | <img src="img/viewfrustum_culling.gif" width="100%"> | <img src="img/distance_culling.gif" width="100%"> |


### Orientation Culling

### View-Frustum Culling

### Distance Culling


##

