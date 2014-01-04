#!/usr/bin/env python

import sys
import numpy
import h5py
import png

# It is better (faster) to use h5topng if it is available:
# h5topng frames.h5 -o frame.png -m 0 -M 2 -c hot -x 1:600

if __name__ == "__main__":
    filename = sys.argv[1]
    if len(sys.argv) == 2:
        frameformat = "frame%04i.png"
    else:
        frameformat = sys.argv[2]
        
    framefile = h5py.File(filename)
    for i, frame in enumerate(framefile['frames']):
        filename = frameformat % i
        print filename
        png.from_array(frame*100, mode="L").save(filename)

        
