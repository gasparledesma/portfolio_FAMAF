#!/bin/bash

## ffmpeg -framerate 1/5 -i spiral%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p out.mp4

ffmpeg -framerate 10 -i bessel%03d.png out.mp4
